import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:MagicFlutter/storage/Storage.dart';

class DeckStorage extends Storage<MagicDeck> {
  DeckStorage() : super('my_decks');

  Future<List<MagicDeck>> get() async {
    dynamic myDecks = await this.storage.getItem('decks');
    if (myDecks == null)
      return [];
    else
      return (myDecks as List).map((dynamic e) => new MagicDeck.fromJson(e)).toList();
  }

  void set(List<MagicDeck> value) async {
    await this.storage.setItem('decks', value.map((e) => e.toJson()).toList());
  }

  void removeDeck(int id) async {
    List<MagicDeck> myDecks = await get();
    for (int i = 0; i < myDecks.length ; i++) {
      if (myDecks[i].id == id) {
        myDecks.removeWhere((e) => e.id == id);
        set(myDecks);
        return;
      }
    }
  }

  //return the deck id
  Future<int> createDeck(String name, String description) async {
    List<MagicDeck> myDecks = await get();
    int id = DateTime.now().millisecondsSinceEpoch;

    MagicDeck newDeck = new MagicDeck(
      name: name,
      description: description,
      cards: [],
      identity: '',
      id: id,
    );

    myDecks.add(newDeck);
    set(myDecks);
    return id;
  }

  Future addToDeck(MagicCard item, int deckId) async {
    List<MagicDeck> myDecks = await get();
    MagicDeck currentDeck;

    for (int i = 0; i < myDecks.length; i++) {
      if (myDecks[i].id == deckId) {
        currentDeck = myDecks[i];
        break;
      }
    }

    if (currentDeck == null) return;

    MagicCard newItem = item;
    bool found = false;
    int cardIndex = -1;

    for (int i = 0; i < currentDeck.cards.length; i++) {
      if (currentDeck.cards[i].id ==
          item.id) {
        newItem.count = currentDeck.cards[i].count;
        found = true;
        cardIndex = i;
        break;
      }
    }

    if (cardIndex == -1 || found == false) {
      newItem.count = 1;
      currentDeck.cards.add(newItem);
    } else {
      newItem.count += 1;
      currentDeck.cards[cardIndex] = newItem;
    }

    currentDeck.identity = getColorIdentity(currentDeck.cards);
    set(myDecks);
  }

  void removeToDeck(MagicCard item, int deckId) async {
    List<MagicDeck> myDecks = await get();
    MagicDeck currentDeck;

    for (int i = 0; i < myDecks.length; i++) {
      if (myDecks[i].id == deckId) {
        currentDeck = myDecks[i];
        break;
      }
    }

    if (currentDeck == null) return;

    for (int i = 0; i < currentDeck.cards.length; i++) {
      if (currentDeck.cards[i].id == item.id) {
        if (currentDeck.cards[i].count == null) {
          currentDeck.cards[i].count = 0;
        }
        currentDeck.cards[i].count -= 1;
        if (currentDeck.cards[i].count <= 0) {
          currentDeck.cards.remove(currentDeck.cards[i]);
        }
        break;
      }
    }

    currentDeck.identity = getColorIdentity(currentDeck.cards);
    set(myDecks);
  }

  String getColorIdentity(List<MagicCard> cards) {
    String colors = "";
    for (int i = 0; i < cards.length; i++) {
      for (int j = 0; j < cards[i].colorIdentity.length; j++) {
        if (colors.contains(cards[i].colorIdentity[j], 0) == false) {
          colors += cards[i].colorIdentity[j];
        }
      }
    }
    return colors;
  }

  void clear() {
    storage.clear();
  }
}
