import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/screens/DeckScreen.dart';
import 'package:flutter/material.dart';

class Deck extends StatefulWidget {
  final GestureTapCallback onTap;

  Deck({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  _DeckState createState() => _DeckState();
}

class _DeckState extends State<Deck> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ActionItem(
        onTap: widget.onTap,
        item: Container (
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('name'),
              Image.network('http://placehold.it/210x297')
            ],
          ),
        )
      )
    );
  }
}