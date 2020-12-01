import 'package:cry/cry_list_view.dart';
import 'package:cry/cry_search_bar.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/page_model.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_portal/api/image_api.dart';
import 'package:flutter_portal/models/image.dart' as model;
import 'package:cry/model/response_body_api.dart';

import 'image_card.dart';

class ImageList extends StatefulWidget {
  @override
  ImageListState createState() => ImageListState();
}

class ImageListState extends State<ImageList> {
  List<model.Image> imageList = [];
  model.Image image = model.Image();
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
        this.image.title = v;
        this.reloadData();
      },
    );

    var listView = CryListView(
      cryListViewType: CryListViewType.wrap,
      count: imageList.length,
      getCell: (index) {
        return ImageCard(imageList[index]);
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
    imageList = [];
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
    RequestBodyApi requestBodyApi = RequestBodyApi(params: image.toJson(), page: page);
    ResponseBodyApi responseBodyApi = await ImageApi.page(requestBodyApi.toMap());
    page = PageModel.fromMap(responseBodyApi.data);
    imageList = [...imageList, ...page.records.map((e) => model.Image.fromJson(e)).toList()];
    if (page.current == page.pages) {
      anyMore = false;
    }
    this.setState(() {});
  }
}
