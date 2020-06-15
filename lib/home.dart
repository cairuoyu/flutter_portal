import 'package:flutter/material.dart';
import 'package:flutter_portal/utils/utils.dart';
import 'package:flutter_portal/video/videoList.dart';

import 'image/imageList.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final tabs = ['图片', '视频'];

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = Scaffold(
      body: TabBarView(
        children: [ImageList(), VideoList()],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("FLUTTER_PORTAL"),
        bottom: TabBar(
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.code),
            onPressed: () {
              Utils.launchURL("https://github.com/cairuoyu/flutter_portal");
            },
          ),
        ],
      ),
    );
    Widget widget = DefaultTabController(
      length: tabs.length,
      child: scaffold,
    );
    return widget;
  }
}
