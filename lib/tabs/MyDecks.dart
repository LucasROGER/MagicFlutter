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
    print(decks);
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
              onTap: () {
                Navigator.pushNamed(context, '/deck/' + item['id'].toString());
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
