import 'package:localstorage/localstorage.dart';

typedef storageCallback = void Function(dynamic item);

class CollectionStorage {
  final LocalStorage storage = new LocalStorage('my_storage');

  Future<List> get() async {
    var myCollection = await storage.getItem('cards');
    if (myCollection == null)
      return [];
    else
      return myCollection;
  }

  void set(value) async {
    await storage.setItem('cards', value);
  }

  Future<List> removeOneFromCollection(dynamic item) async {
    List myCards = await get();
    int i = 0;
    for (; i < myCards.length; i++) {
      if (myCards[i] == item) {
        myCards[i]['count'] -= 1;
        if (myCards[i]['count'] <= 0) {
          myCards.remove(item);
          set(myCards);
        }
      }
    }
    return myCards;
  }

  Future<List> addOneToCollection(dynamic item) async {
    List myCards = await get();
    int i = 0;
    for (; i < myCards.length; i++) {
      if (myCards[i] == item) {
        myCards[i]['count'] += 1;
      }
    }
    set(myCards);
    return myCards;
  }

  Future<List> removeFromCollection(dynamic item) async {
    List myCards = await get();
    myCards.remove(item);
    set(myCards);
    return myCards;
  }

  Future<List> addToCollection(dynamic item) async {
    var myCards = await get();
    if (myCards == null) {
      myCards = [];
    }
    var newItem = item;
    int index = -1;
    bool found = false;
    for (int i = 0; i < myCards.length; i++) {
      if (myCards[i]['identifiers']['multiverseId'] ==
          newItem['identifiers']['multiverseId']) {
        newItem['count'] = myCards[i]['count'];
        found = true;
        index = i;
        break;
      }
    }
    if (index == -1 || found == false) {
      newItem['count'] = 1;
      myCards.add(newItem);
    } else {
      newItem['count'] += 1;
      myCards[index] = newItem;
    }
    set(myCards);
    return myCards;
  }

  void clear() {
    storage.clear();
  }
}
