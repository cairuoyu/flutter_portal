import 'package:flutter/material.dart';
import 'package:flutter_portal/models/video.dart';
import 'package:flutter_portal/utils/adaptiveUtil.dart';
import 'package:video_player/video_player.dart';
import 'aspectRatioVideo.dart';

class VideoCard extends StatefulWidget {
  VideoCard(this.videoModel);

  final Video videoModel;

  @override
  State<StatefulWidget> createState() => VideoCardState();
}

class VideoCardState extends State<VideoCard> {
  double width = 700;
  VideoPlayerController controller;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Card card = Card(
      child: Column(
        children: [
          previewVideo(),
          IconButton(
              onPressed: play,
              icon: Icon(controller.value.isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline)),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(widget.videoModel.title),
          ),
        ],
      ),
    );

    Widget result = Container(
      padding: EdgeInsets.all(10),
      child: card,
    );

    return result;
  }

  play() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    setState(() {});
  }

  init() async {
    controller = VideoPlayerController.network(widget.videoModel.url);
    await controller.setVolume(1.0);
    await controller.initialize();
    await controller.setLooping(true);
  }

  Widget previewVideo() {
    return controller == null
        ? Container()
        : Container(
            width: isDisplayDesktop(context) ? width : double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: AspectRatioVideo(controller),
          );
  }

  void disposeController() async {
    if (controller != null) {
      await controller.setVolume(0.0);
      await controller.dispose();
      controller = null;
    }
  }

  @override
  void dispose() async {
    disposeController();
    super.dispose();
  }
}
