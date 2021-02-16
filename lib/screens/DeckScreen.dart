import 'package:MagicFlutter/components/DualList.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id.toString()) // TODO Replace with deck name
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
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
        ),
      ),
    );
  }
}
