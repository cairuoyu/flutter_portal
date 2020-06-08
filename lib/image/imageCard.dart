import 'package:flutter/material.dart';
import 'package:flutter_portal/models/image.dart' as model;

class ImageCard extends StatelessWidget {
  model.Image imageModel;
  double width = 200;

  ImageCard(this.imageModel);

  @override
  Widget build(BuildContext context) {
    Image image = Image(
      image: NetworkImage(imageModel.url),
      width: width,
      height: width,
    );
    Card card = Card(
      child: Column(
        children: [
          image,
          Container(
            padding: EdgeInsets.all(5),
            child: Text(imageModel.title),
          ),
        ],
      ),
    );

    Widget widget = Container(
      padding: EdgeInsets.all(10),
      child: card,
    );

    return widget;
  }
}
