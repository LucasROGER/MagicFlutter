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

  Future<List> addToDeck(dynamic item, int deckId) async {
    List myDecks = await get();

    for (int i = 0; i < myDecks.length; i++) {

    }
  }

  void clear() {
    storage.clear();
  }
}
