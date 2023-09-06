import 'package:cached_network_image/cached_network_image.dart';
import 'package:cry/model/image_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCard extends StatelessWidget {
  final ImageModel imageModel;

  ImageCard(this.imageModel);

  @override
  Widget build(BuildContext context) {
    CachedNetworkImage image = CachedNetworkImage(
      imageUrl: imageModel.url ?? '--',
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
    Card card = Card(
      child: Column(
        children: [
          InkWell(
            child: image,
            onTap: () => Get.to(
              Scaffold(
                body: InkWell(
                  child: Center(child: image),
                  onTap: () => Get.back(),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(imageModel.title ?? '--'),
          ),
        ],
      ),
    );
    return card;
  }
}
