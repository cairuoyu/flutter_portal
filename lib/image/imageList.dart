import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_portal/api/imageApi.dart';
import 'package:flutter_portal/models/image.dart' as model;
import 'package:flutter_portal/models/requestBodyApi.dart';
import 'package:flutter_portal/models/responeBodyApi.dart';

import 'imageCard.dart';

class ImageList extends StatefulWidget {
  @override
  ImageListState createState() => ImageListState();
}

class ImageListState extends State<ImageList> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<model.Image> imageList = [];
  model.Image image = model.Image();
  ScrollController controller = new ScrollController();
  bool toTopButtonVisible = false;

  search() {
    FormState form = formKey.currentState;
    form.save();
    loadData();
  }

  loadData() async {
    RequestBodyApi requestBodyApi = RequestBodyApi(params: image.toJson());
    ResponeBodyApi responeBodyApi = await ImageApi.list(requestBodyApi);
    var data = responeBodyApi.data;
    imageList = List.from(data).map((e) => model.Image.fromJson(e)).toList();
    this.setState(() {});
  }

  @override
  void initState() {
    controller.addListener(() {
      double topLimit = 500;
      if (controller.offset < topLimit && toTopButtonVisible) {
        toTopButtonVisible = false;
        setState(() {});
      } else if (controller.offset > topLimit && !toTopButtonVisible) {
        toTopButtonVisible = true;
        setState(() {});
      }
    });
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
            image.title = v;
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
    int rowConunt = imageList.length ~/ columnCount + 1;
    var listView = ListView(
      controller: controller,
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
                        child: (index > imageList.length - 1) ? Container() : ImageCard(imageList[index]),
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
    var result = Scaffold(
      body: listView,
      floatingActionButton: !toTopButtonVisible
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                controller.animateTo(
                  .0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                );
              },
            ),
    );
    return result;
  }
}
