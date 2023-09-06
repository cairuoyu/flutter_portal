import 'package:flutter/material.dart';
import 'package:flutter_portal/models/video.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'aspect_ratio_video.dart';

class VideoPreview extends StatefulWidget {
  VideoPreview(this.videoModel, {this.isFullScreen = false});

  final Video videoModel;
  final bool isFullScreen;

  @override
  State<StatefulWidget> createState() => VideoPreviewState();
}

class VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController controller;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var result = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatioVideo(controller),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: play, icon: Icon(controller.value.isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline)),
              widget.isFullScreen ? Container() : IconButton(icon: Icon(Icons.fullscreen), onPressed: fullScreen),
            ],
          ),
        ],
      ),
    );

    return result;
  }

  @override
  void dispose() async {
    super.dispose();
    if (controller != null) {
      await controller.setVolume(0.0);
      await controller.dispose();
      // controller = null;
    }
  }

  init() async {
    controller = VideoPlayerController.network(widget.videoModel.url ?? '--');
    await controller.setVolume(1.0);
    await controller.initialize();
    await controller.setLooping(true);
  }

  play() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    setState(() {});
  }

  fullScreen() {
    Get.to(
      Scaffold(
        appBar: AppBar(title: Text(widget.videoModel.title ?? '--')),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: VideoPreview(
            widget.videoModel,
            isFullScreen: true,
          ),
        ),
      ),
    );
  }
}
