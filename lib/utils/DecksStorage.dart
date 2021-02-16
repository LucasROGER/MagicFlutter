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

  void removeDeck(id) async {
    List myDecks = await get();
    for (int i = 0; i < myDecks.length ; i++) {
      if (myDecks[i]['id'] == id) {
        myDecks.remove(myDecks[i]);
        set(myDecks);
        return;
      }
    }
  }

  //return the deck id
  Future<int> createDeck(String name, String description, List cards) async {
    List myDecks = await get();
    int id = DateTime.now().millisecondsSinceEpoch;

    if (cards == null) cards = [];
    String colors = getColorIdentity(cards);


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

  Future addToDeck(dynamic item, int deckId) async {
    List myDecks = await get();
    dynamic currentDeck;
    currentDeck = null;
    int deckIndex = -1;
    for (int i = 0; i < myDecks.length; i++) {
      if (myDecks[i]['id'] == deckId) {
        currentDeck = myDecks[i];
        deckIndex = i;
        break;
      }
    }
    if (deckIndex == -1 || currentDeck == null) return;
    dynamic newItem = item;
    bool found = false;
    int cardIndex = -1;
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

  void removeToDeck(dynamic item, int deckId) async {
    List myDecks = await get();
    dynamic currentDeck = null;
    int deckIndex = -1;
    for (int i = 0; i < myDecks.length; i++) {
      if (myDecks[i]['id'] == deckId) {
        currentDeck = myDecks[i];
        deckIndex = i;
        break;
      }
    }
    if (deckIndex == -1 || currentDeck == null) return;
    for (int i = 0; i < currentDeck['cards'].length; i++) {
      if (currentDeck['cards'][i]['identifiers']['multiverseId'] ==
          item['identifiers']['multiverseId']) {
        if (currentDeck['cards'][i]['count'] == null)
          currentDeck['cards'][i]['count'] = 0;
        currentDeck['cards'][i]['count'] -= 1;
        if (currentDeck['cards'][i]['count'] <= 0) {
          currentDeck['cards'].remove(currentDeck['cards'][i]);
        }
        break;
      }
    }
    set(myDecks);
  }

  String getColorIdentity(List cards) {
    String colors = "";
    for (int i = 0; i < cards.length; i++) {
      for (int j = 0; j < cards[i]['colorIdentity'].length; j++) {
        if (colors.contains(cards[i]['colorIdentity'][j], 0) == false) {
          colors += cards[i]['colorIdentity'][j];
        }
      }
    }
    return colors;
  }

  void clear() {
    storage.clear();
  }
}
