import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_portal/api/videoApi.dart';
import 'package:flutter_portal/common/cryListView.dart';
import 'package:flutter_portal/common/crySearchBar.dart';
import 'package:flutter_portal/models/index.dart' as model;
import 'package:flutter_portal/models/requestBodyApi.dart';
import 'package:flutter_portal/models/responeBodyApi.dart';

import 'videoCard.dart';

class VideoList extends StatefulWidget {
  @override
  VideoListState createState() => VideoListState();
}

class VideoListState extends State<VideoList> {
  List<model.Video> videoList = [];
  model.Video video = model.Video();
  model.Page page = model.Page();
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
    ResponeBodyApi responeBodyApi = await VideoApi.page(requestBodyApi);
    page = model.Page.fromJson(responeBodyApi.data);
    videoList = [...videoList, ...page.records.map((e) => model.Video.fromJson(e)).toList()];
    if (page.current == page.pages) {
      anyMore = false;
    }
    this.setState(() {});
  }
}
