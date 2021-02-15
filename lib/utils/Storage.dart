import 'package:localstorage/localstorage.dart';

typedef storageCallback = void Function(dynamic item);

class Storage {
  final LocalStorage collection = new LocalStorage('my_collection');

  Future<List> removeOneFromCollection(dynamic item) async {
    List myCards = await collection.getItem('cards');
    int i = 0;
    for (; i < myCards.length; i++) {
      if (myCards[i] == item) {
        myCards[i]['count'] -= 1;
        if (myCards[i]['count'] == 0) {
          myCards.remove(item);
          await collection.setItem('cards', myCards);
        }
      }
    }
    return myCards;
  }

  Future<List> addOneToCollection(dynamic item) async {
    List myCards = await collection.getItem('cards');
    int i = 0;
    for (; i < myCards.length; i++) {
      if (myCards[i] == item) {
        myCards[i]['count'] += 1;
      }
    }
    await collection.setItem('cards', myCards);
    return myCards;
  }

  Future<List> removeFromCollection(dynamic item) async {
    List myCards = await collection.getItem('cards');
    myCards.remove(item);
    await collection.setItem('cards', myCards);
    return myCards;
  }

  Future<List> addToCollection(dynamic item) async {
    var myCards = await collection.getItem('cards');
    if (myCards == null) {
      myCards = [];
    }
    var newItem = item;
    int index = -1;
    bool found = false;
    for (int i = 0; i < myCards.length; i++) {
      if (myCards[i]['identifiers']['multiverseId'] ==
          newItem['identifiers']['multiverseId']) {
        newItem = myCards[i];
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
    await collection.setItem('cards', myCards);
    return myCards;
  }

  void deleteCollection() async {
    await collection.clear();
  }
}
