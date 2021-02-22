import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:flutter/services.dart';

class SearchBar extends StatefulWidget {
  final List<MagicCard> list;
  List<MagicCard> newList;

  SearchBar({
    Key key,
    this.list,
    this.newList,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          onChanged: (String value) {
            widget.list.forEach((element) {
              if(value.length == 0 || value.compareTo(element.name.substring(0, value.length)) == 0) {
                widget.newList.add(element);
              }
            });
          },
          decoration: InputDecoration(
            hintText: 'Search',
            border: OutlineInputBorder(),
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
            ),
          ),
        )
    );
  }
}
