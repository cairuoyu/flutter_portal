import 'package:flutter/material.dart';
import 'package:flutter_portal/models/video.dart';
import 'package:flutter_portal/video/video_preview.dart';

class VideoCard extends StatefulWidget {
  VideoCard(this.videoModel);

  final Video videoModel;

  @override
  State<StatefulWidget> createState() => VideoCardState();
}

class VideoCardState extends State<VideoCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            VideoPreview(widget.videoModel),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(widget.videoModel.title),
            ),
          ],
        ),
      ),
    );
    return result;
  }
}
