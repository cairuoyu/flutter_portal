import 'package:flutter/material.dart';
import 'package:flutter_portal/api/videoApi.dart';
import 'package:flutter_portal/models/video.dart' as model;
import 'package:flutter_portal/models/requestBodyApi.dart';
import 'package:flutter_portal/models/responeBodyApi.dart';

import 'videoCard.dart';

class VideoList extends StatefulWidget {
  @override
  VideoListState createState() => VideoListState();
}

class VideoListState extends State<VideoList> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<model.Video> videoList = [];
  model.Video video = model.Video();

  search() {
    FormState form = formKey.currentState;
    form.save();
    loadData();
  }

  loadData() async {
    RequestBodyApi requestBodyApi = RequestBodyApi(params: video.toJson());
    ResponeBodyApi responeBodyApi = await VideoApi.list(requestBodyApi);
    var data = responeBodyApi.data;
    videoList = List.from(data).map((e) => model.Video.fromJson(e)).toList();
    this.setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var searchFrom = Form(
      key: formKey,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: TextFormField(
          onEditingComplete: () {
            search();
          },
          onSaved: (v) {
            video.title = v;
          },
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
              hintText: '查询：标题',
              suffixIcon: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: search,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
    double width = MediaQuery.of(context).size.width;
    int columnCount = width ~/ 500 + 1;
    int rowConunt = videoList.length ~/ columnCount + 1;
    var result = ListView(
      children: [
        searchFrom,
        Column(
          children: [
            ...List<Widget>.generate(
              rowConunt,
              (y) {
                return Row(
                  children: [
                    ...List<Widget>.generate(columnCount, (x) {
                      int index = columnCount * y + x;
                      var card = Padding(
                        padding: EdgeInsets.all(10),
                        child: (index > videoList.length - 1) ? Container() : VideoCard(videoList[index]),
                      );
                      return Expanded(
                        child: card,
                      );
                    }),
                  ],
                );
              },
            ),
          ],
        )
      ],
    );
    return result;
  }
}
