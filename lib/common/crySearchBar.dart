import 'package:flutter/material.dart';

class CrySearchBar extends StatelessWidget {
  final ValueChanged onSearch;
  const CrySearchBar({Key key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchFrom = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: TextField(
        onSubmitted: (v) {
          onSearch(v);
        },
        cursorColor: Theme.of(context).primaryColor,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
            hintText: '查询：标题',
            // suffixIcon: Material(
            //   elevation: 2.0,
            //   borderRadius: BorderRadius.all(Radius.circular(30)),
            //   child: IconButton(
            //     icon: Icon(Icons.search),
            //     onPressed: (){}
            //   ),
            // ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
      ),
    );
    return searchFrom;
  }
}
