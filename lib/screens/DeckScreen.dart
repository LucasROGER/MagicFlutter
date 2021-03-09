import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/components/CardDialog.dart';
import 'package:MagicFlutter/components/CardList.dart';
import 'package:MagicFlutter/components/DualList.dart';
import 'package:MagicFlutter/screens/base/Screen.dart';
import 'package:MagicFlutter/storage/DecksStorage.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/class/MagicCard.dart';

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
  DeckStorage storage = new DeckStorage();
  MagicDeck deck;
  List<MagicCard> cardList;
  List<MagicCard> displayedCards;
  bool displayStats = true;

  void _getDeckData() async {
    List<MagicDeck> allDecks = await storage.get();
    for (int i = 0; i < allDecks.length; i++) {
      if (allDecks[i].id == widget.id) {
        setState(() {
          this.deck = allDecks[i];
          this.cardList = allDecks[i].cards;
        });
        break;
      }
    }
  }

  void _addToDeck(MagicCard item) {
    storage.addToDeck(item, widget.id);
    _getDeckData();
  }

  void _removeDeck() {
    storage.removeDeck(widget.id);
    Navigator.of(context).pop(true);
  }

  void _removeOneToDeck(MagicCard item) {
    storage.removeToDeck(item, widget.id);
    _getDeckData();
  }

  @override
  void didUpdateWidget(covariant DeckScreen oldWidget) {
    if (oldWidget != widget) {
      _getDeckData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _getDeckData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.delete),
          tooltip: 'Delete deck',
          onPressed: () {
            _removeDeck();
          },
        ),
      ],
      title: this.deck == null ? '' : this.deck.name,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/deck/' + widget.id.toString() + '/stats');
            },
            child: Text('See stats'),
          ),
          Expanded(
            flex: 1,
            child: CardList(
              cards: this.cardList,
              onTapCard: (dynamic item) => {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    return CardDialog(
                      item: item,
                      addCallback: _addToDeck,
                      removeOneCallback: _removeOneToDeck,
                    );
                  },
                )
              },
            )
          ),
        ],
      ),
    );
  }
}