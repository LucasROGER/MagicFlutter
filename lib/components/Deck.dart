import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:flutter/material.dart';

class Deck extends StatefulWidget {
  final GestureTapCallback onTap;
  final MagicDeck deck;

  Deck({
    Key key,
    this.onTap,
    this.deck,
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
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(widget.deck == null ? 'name' : widget.deck.name),
              Image.network('http://placehold.it/210x297')
            ],
          ),
        )
      )
    );
  }
}