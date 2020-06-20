import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_portal/api/imageApi.dart';
import 'package:flutter_portal/common/cryListView.dart';
import 'package:flutter_portal/common/crySearchBar.dart';
import 'package:flutter_portal/models/index.dart' as model;
import 'package:flutter_portal/models/requestBodyApi.dart';
import 'package:flutter_portal/models/responeBodyApi.dart';

import 'imageCard.dart';

class ImageList extends StatefulWidget {
  @override
  ImageListState createState() => ImageListState();
}

class ImageListState extends State<ImageList> {
  List<model.Image> imageList = [];
  model.Image image = model.Image();
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
        this.image.title = v;
        this.reloadData();
      },
    );

    var listView = CryListView(
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
    ResponeBodyApi responeBodyApi = await ImageApi.page(requestBodyApi);
    page = model.Page.fromJson(responeBodyApi.data);
    imageList = [...imageList, ...page.records.map((e) => model.Image.fromJson(e)).toList()];
    if (page.current == page.pages) {
      anyMore = false;
    }
    this.setState(() {});
  }
}
