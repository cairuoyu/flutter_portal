import 'package:cry/cry_list_view.dart';
import 'package:cry/cry_search_bar.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_portal/api/video_api.dart';
import 'package:flutter_portal/models/video.dart' as model;
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';

import 'video_card.dart';

class VideoList extends StatefulWidget {
  @override
  VideoListState createState() => VideoListState();
}

class VideoListState extends State<VideoList> {
  List<model.Video> videoList = [];
  model.Video video = model.Video();
  PageModel page = PageModel(orders: [OrderItemModel(column: 'create_time')]);
  bool anyMore = true;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var searchForm = CrySearchBar(
      onSearch: (v) {
        this.video.title = v;
        this.reloadData();
      },
    );

    var listView = CryListView(
      cryListViewType: CryListViewType.wrap,
      count: videoList.length,
      getCell: (index) {
        return VideoCard(videoList[index]);
      },
      loadMore: loadMore,
      onRefresh: reloadData,
    );
    var result = Stack(
      children: [
        Padding(
          child: listView,
          padding: EdgeInsets.only(top: 50),
        ),
        searchForm,
      ],
    );
    return result;
  }

  Future reloadData() async {
    page.current = 1;
    videoList = [];
    anyMore = true;
    await loadData();
  }

  loadMore() {
    if (!anyMore) {
      return;
    }
    page.current++;
    loadData();
  }

  loadData() async {
    RequestBodyApi requestBodyApi = RequestBodyApi(params: video.toJson(), page: page);
    ResponseBodyApi responseBodyApi = await VideoApi.page(requestBodyApi.toMap());
    page = PageModel.fromMap(responseBodyApi.data);
    videoList = [...videoList, ...page.records.map((e) => model.Video.fromJson(e)).toList()];
    if (page.current == page.pages) {
      anyMore = false;
    }
    this.setState(() {});
  }
}
