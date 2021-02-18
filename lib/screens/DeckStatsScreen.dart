import 'package:MagicFlutter/utils/Extensions.dart';
import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:MagicFlutter/screens/base/Screen.dart';
import 'package:MagicFlutter/utils/DecksStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/Title.dart' as Title;

class DeckStatsScreen extends StatefulWidget {
  final int id;

  DeckStatsScreen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _DeckStatsScreenState createState() => _DeckStatsScreenState();
}

class _DeckStatsScreenState extends State<DeckStatsScreen> {
  DeckStorage storage = new DeckStorage();
  MagicDeck deck;

  void _getDeck() async {
    List<MagicDeck> decks = await storage.get();
    for (int i = 0; i < decks.length; i++) {
      if (decks[i].id == widget.id) {
        setState(() {
          this.deck = decks[i];
        });
        break;
      }
    }
  }

  List<Widget> getCardsType() {
    List<String> cardTypes = [];
    Map<String, int> types = new Map<String, int>();
    List<Widget> stats = [];

    stats.add(
      Title.Title(
        text: 'Card types',
      ),
    );

    stats.add(
      SizedBox(height: 10),
    );

    if (deck.cards.isEmpty) {
      stats.add(Text('No cards'));
      return stats;
    }

    for (int i = 0; i < deck.cards.length; i++) {
      cardTypes += (List.from(deck.cards[i].types).cast<String>()) * deck.cards[i].count;
    }

    while (cardTypes.isNotEmpty) {
      String type = cardTypes[0];
      types[type] = cardTypes.where((element) => element == type).length;
      cardTypes.removeWhere((e) => e == type);
    }

    types.forEach((key, value) {
      stats.add(
        Text('$key: $value')
      );
    });

    return stats;
  }

  @override
  initState() {
    _getDeck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (this.deck == null) return Container();
    return Screen(
      title: 'Stats',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...getCardsType(),
        ],
      ),
    );
  }
}
