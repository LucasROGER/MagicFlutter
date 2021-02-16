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

  final decks = <Deck>[Deck(), Deck(), Deck()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DualList<Deck>(
          list: decks,
          renderItem: (context, i, item) {
            return Deck(
              onTap: () {
                Navigator.pushNamed(context, '/deck/' + i.toString());
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/deck/create');
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
