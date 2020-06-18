import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_portal/api/videoApi.dart';
import 'package:flutter_portal/common/cryListView.dart';
import 'package:flutter_portal/common/crySearchBar.dart';
import 'package:flutter_portal/models/video.dart' as model;
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
        this.loadData();
      },
    );

    var listView = CryListView(
      count: videoList.length,
      getCell: (index) {
        return VideoCard(videoList[index]);
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
    RequestBodyApi requestBodyApi = RequestBodyApi(params: video.toJson());
    ResponeBodyApi responeBodyApi = await VideoApi.list(requestBodyApi);
    var data = responeBodyApi.data;
    videoList = List.from(data).map((e) => model.Video.fromJson(e)).toList();
    this.setState(() {});
  }
}

