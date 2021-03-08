import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:MagicFlutter/components/Deck.dart';
import 'package:MagicFlutter/components/DualList.dart';
import 'package:MagicFlutter/utils/DecksStorage.dart';
import 'package:MagicFlutter/utils/SoundController.dart';
import 'package:flutter/material.dart';

class MyDecksView extends StatefulWidget {
  MyDecksView({
    Key key,
  }) : super(key: key);

  @override
  _MyDecksViewState createState() => _MyDecksViewState();
}

class _MyDecksViewState extends State<MyDecksView> {
  final SoundController sound = new SoundController();
  final DeckStorage storage = new DeckStorage();
  List<MagicDeck> deckList = [];

  void _getDecks() async {
    List<MagicDeck> decks =  await storage.get();
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
        body: DualList<MagicDeck>(
          list: deckList,
          renderItem: (BuildContext context, int i, dynamic item) {
            return Deck(
              deck: item,
              onTap: (dynamic _null) async {
                if (await Navigator.pushNamed(context, '/deck/' + item.id.toString()) == true)
                  _getDecks();
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await Navigator.pushNamed(context, '/deck/create') == true) {
              _getDecks();
            }
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
