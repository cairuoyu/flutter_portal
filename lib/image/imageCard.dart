import 'package:flutter/material.dart';
import 'package:flutter_portal/models/image.dart' as model;

class ImageCard extends StatelessWidget {
  final model.Image imageModel;
  final double width = 700;

  ImageCard(this.imageModel);

  @override
  Widget build(BuildContext context) {
    Image image = Image(
      image: NetworkImage(imageModel.url),
      width: double.infinity,
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
    return card;
  }
}
