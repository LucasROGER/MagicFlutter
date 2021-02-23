import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef updateCardListFct = void Function(List<MagicCard> newList);

class SearchBar extends StatefulWidget {
  final List<MagicCard> list;
  final updateCardListFct updateFct;

  SearchBar({
    Key key,
    this.list,
    this.updateFct,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController filterValue = new TextEditingController();
  bool matchCase = false;

  void updateList() {
    widget.updateFct(widget.list
        .where((item) => this.matchCase ? item.name.contains(filterValue.text) : item.name.toLowerCase().contains(filterValue.text.toLowerCase()))
        .toList());
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          controller: filterValue,
          onChanged: (String value) => updateList(),
          decoration: InputDecoration(
            labelText: 'Search',
            border: const OutlineInputBorder(),
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                return;
              },
            ),
            suffixIcon: IconButton(
              color:
                  this.matchCase ? Theme.of(context).accentColor : Colors.grey,
              icon: Icon(Icons.spellcheck),
              onPressed: () {
                setState(() {
                  this.matchCase = !this.matchCase;
                });
                updateList();
              },
            ),
          ),
        ));
  }
}
