import 'package:MagicFlutter/components/Deck.dart';
import 'package:MagicFlutter/components/DualList.dart';
import 'package:MagicFlutter/utils/DecksStorage.dart';
import 'package:flutter/material.dart';

class MyDecksView extends StatefulWidget {
  MyDecksView({
    Key key,
  }) : super(key: key);

  @override
  _MyDecksViewState createState() => _MyDecksViewState();
}

class _MyDecksViewState extends State<MyDecksView> {
  final DeckStorage storage = new DeckStorage();
  List deckList = [];

  void _getDecks() async {
    List decks =  await storage.get();
    setState(() {
      this.deckList = decks;
    });
  }

  @override
  void initState() {
    _getDecks();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DualList<dynamic>(
          list: deckList,
          renderItem: (context, i, item) {
            return Deck(
              deck: item,
              onTap: () async {
                if (await Navigator.pushNamed(context, '/deck/' + item['id'].toString()) == true)
                  _getDecks();
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await Navigator.pushNamed(context, '/deck/create') == true)
              _getDecks();

          },
          child: Icon(Icons.add),
        ),
    );
  }
}
