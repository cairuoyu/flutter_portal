import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_portal/api/imageApi.dart';
import 'package:flutter_portal/common/cryListView.dart';
import 'package:flutter_portal/common/crySearchBar.dart';
import 'package:flutter_portal/models/image.dart' as model;
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
        this.loadData();
      },
    );

    var listView = CryListView(
      count: imageList.length,
      getCell: (index) {
        return ImageCard(imageList[index]);
      },
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

  loadData() async {
    RequestBodyApi requestBodyApi = RequestBodyApi(params: image.toJson());
    ResponeBodyApi responeBodyApi = await ImageApi.list(requestBodyApi);
    var data = responeBodyApi.data;
    imageList = List.from(data).map((e) => model.Image.fromJson(e)).toList();
    this.setState(() {});
  }
}
