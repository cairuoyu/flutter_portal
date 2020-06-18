import 'package:flutter/material.dart';

class CryListView extends StatefulWidget {
  final int count;
  final Function getCell;
  CryListView({Key key, this.count, this.getCell}) : super(key: key);

  @override
  CryListViewState createState() => CryListViewState();
}

class CryListViewState extends State<CryListView> {
  ScrollController controller = new ScrollController();
  bool toTopButtonVisible = false;
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
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int columnCount = width ~/ 500 + 1;
    int rowConunt = widget.count ~/ columnCount + 1;
    var listView = ListView(
      controller: controller,
      children: [
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
                          child: (index > widget.count - 1) ? Container() : widget.getCell(index));
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
