import 'package:MagicFlutter/components/Deck.dart';
import 'package:MagicFlutter/components/DualList.dart';
import 'package:flutter/material.dart';

class MyDecksView extends StatefulWidget {
  MyDecksView({
    Key key,
  }) : super(key: key);

  @override
  _MyDecksViewState createState() => _MyDecksViewState();
}

class _MyDecksViewState extends State<MyDecksView> {

  final decks = <Deck>[Deck(), Deck(), Deck(), Deck(), Deck(), Deck(), Deck(), Deck(), Deck(), Deck(), Deck()];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DualList(
          list: decks,
        ),
    );
  }
}
