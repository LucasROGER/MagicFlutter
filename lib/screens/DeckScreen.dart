import 'package:flutter/material.dart';

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
    return Container(
      child: Center(
        child: Text(widget.id.toString()),
      ),
    );
  }
}
