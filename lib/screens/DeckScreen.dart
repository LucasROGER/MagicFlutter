import 'package:MagicFlutter/components/DualList.dart';
import 'package:MagicFlutter/screens/base/Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DeckScreen extends StatefulWidget {
  final int id;

  DeckScreen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _DeckScreenState createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  @override
  Widget build(BuildContext context) {
    return Screen(
      title: widget.id.toString(),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/deck/' + widget.id.toString() + '/stats');
            },
            child: Text('See stats'),
          ),
          Expanded(
            flex: 1,
            child: DualList<dynamic>(
              renderItem: (ctxt, i, item) {
                return Container();
              },
              list: [],
            ),
          )
        ],
      ),
    );
  }
}
