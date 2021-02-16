import 'dart:convert';

import 'package:localstorage/localstorage.dart';

class DeckStorage {
  final LocalStorage storage = new LocalStorage('my_decks');

  Future<List> get() async {
    var myDecks = await storage.getItem('decks');
    if (myDecks == null)
      return [];
    else
      return myDecks;
  }
  void set(value) async {
    await storage.setItem('decks', value);
  }

  //return the deck id
  Future<int> createDeck(String name, String description, List cards) async {
    List myDecks = await get();
    String colors = "";
    int id = DateTime.now().millisecondsSinceEpoch;

    if (cards == null) cards = [];

    for (int i = 0; i < cards.length; i++) {
      for (int j = 0; j < cards[i]['colorIdentity'].length; j++) {
        if (colors.contains(cards[i]['colorIdentity'][j], 0) == false) {
          colors += cards[i]['colorIdentity'][j];
        }
      }
    }

    var newDeck = {
      "name": name,
      "description": description,
      "cards": jsonEncode(cards),
      "identity": colors,
      "id": id,
    };
    myDecks.add(newDeck);
    set(myDecks);
    return id;
  }

  void addToDeck(dynamic item, int deckId) async {
    List myDecks = await get();
    dynamic currentDeck = null;
    int deckIndex = -1;
    print(myDecks.length);
    for (int i = 0; i < myDecks.length; i++) {
      if (myDecks[i]['id'] == deckId) {
        currentDeck = myDecks[i];
        deckIndex = i;
        break;
      }
    }
    if (deckIndex == -1 || currentDeck == null) return;
    var newItem = item;
    bool found = false;
    int cardIndex = -1;
    currentDeck['cards'] = currentDeck['cards'];
    for (int i = 0; i < currentDeck['cards'].length; i++) {
      if (currentDeck['cards'][i]['identifiers']['multiverseId'] ==
          item['identifiers']['multiverseId']) {
        newItem['count'] = currentDeck['cards'][i]['count'];
        found = true;
        cardIndex = i;
        break;
      }
    }
    if (cardIndex == -1 || found == false) {
      newItem['count'] = 1;
      myDecks[deckIndex]['cards'].add(newItem);
    } else {
      newItem['count'] += 1;
      myDecks[deckIndex]['cards'][cardIndex] = newItem;
    }
    set(myDecks);
  }

  void clear() {
    storage.clear();
  }
}
