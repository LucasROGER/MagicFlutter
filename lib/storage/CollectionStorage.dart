import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/storage/Storage.dart';

class CollectionStorage extends Storage<MagicCard> {
  CollectionStorage() : super('my_collection');

  Future<List<MagicCard>> get() async {
    dynamic myCollection = await storage.getItem('cards');
    if (myCollection == null)
      return [];
    else {
      return (myCollection as List)?.map((dynamic item) =>
      new MagicCard.fromJson(item))?.toList();
    }
  }

  void set(List<MagicCard> value) async {
    await storage.setItem('cards', value.map((e) => e.toJson()).toList()) ;
  }

  Future<List<MagicCard>> removeOneFromCollection(MagicCard item) async {
    List<MagicCard> myCards = await get();
    int i = 0;
    for (; i < myCards.length; i++) {
      if (myCards[i].id == item.id) {
        myCards[i].count -= 1;
        myCards.removeWhere((e) => e.count <= 0);
        await set(myCards);
      }
    }
    return myCards;
  }

  Future<List<MagicCard>> addOneToCollection(MagicCard item) async {
    List<MagicCard> myCards = await get();
    int i = 0;
    for (; i < myCards.length; i++) {
      if (myCards[i].id == item.id) {
        myCards[i].count += 1;
      }
    }
    await set(myCards);
    return myCards;
  }

  Future<List<MagicCard>> removeFromCollection(MagicCard item) async {
    List<MagicCard> myCards = await get();
    myCards.removeWhere((e) => e.id == item.id);
    await set(myCards);
    return myCards;
  }

  Future<List<MagicCard>> addToCollection(MagicCard item) async {
    var myCards = await get();
    if (myCards == null) {
      myCards = [];
    }
    var newItem = item;
    int index = -1;
    bool found = false;
    for (int i = 0; i < myCards.length; i++) {
      if (myCards[i].id ==
          newItem.id) {
        newItem.count = myCards[i].count;
        found = true;
        index = i;
        break;
      }
    }
    if (index == -1 || found == false) {
      newItem.count = 1;
      myCards.add(newItem);
    } else {
      newItem.count += 1;
      myCards[index] = newItem;
    }
    await set(myCards);
    return myCards;
  }

  void clear() {
    storage.clear();
  }
}
