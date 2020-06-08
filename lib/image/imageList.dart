import 'package:flutter/material.dart';
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
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
    var list = Wrap(
//      crossAxisAlignment: CrossAxisAlignment.start,
      children: imageList.map((e) {
        return ImageCard(e);
      }).toList(),
    );
    Widget widget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: searchFrom,
        ),
        list,
      ],
    );
    return widget;
  }
}
