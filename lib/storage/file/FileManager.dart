import 'dart:convert';

import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/storage/AllCardsStorage.dart';
import 'package:MagicFlutter/storage/CollectionStorage.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/services.dart';

class FileManager {
  List<String> assets = [
    'KHM',
    'ZNR',
    'M21',
    'IKO',
    'THB',
    'ELD',
    'M20',
    'WAR',
    'GRN',
    'RNA',
    'M19'
  ];

  Future<List<MagicCard>> fromAssets() async {
    List<MagicCard> list = [];

    await assets.forEach((set) async {
      String data = await rootBundle.loadString("assets/data/" + set + ".json");
      final jsonResult = json.decode(data);
      List<dynamic> cardList = jsonResult['data']['cards'];
      cardList.forEach((e) {
        list.add(new MagicCard.fromJson(e));
      });
    });
    return list;
  }

  Future<int> importCollection() async {
    return await FlutterClipboard.paste().then((value) async {
      if (value == null) return -1;
      print(value);
      print(jsonDecode(value));
      AllCardsStorage storage = new AllCardsStorage();
      CollectionStorage collectionStorage = new CollectionStorage();
      List<MagicCard> allCards = await storage.get();
      List jsonList = jsonDecode(value);
      if (jsonList == null) return -1;
      for (int i = 0; i < allCards.length; i++) {
        for (int j = 0; j < jsonList.length; j++) {
          if (allCards[i].id == jsonList[j]['id']) {
            print('allo');
            var cards = await collectionStorage.addOneToCollection(allCards[i]);
          }
        }
      }
      return 0;
    });
  }

  Future<int> exportCollection() async {
    CollectionStorage collectionStorage = new CollectionStorage();
    List<MagicCard> collection = await collectionStorage.get();
    List<MagicCard> rawCollection = [];
    collection.forEach((e) {
      print(e.count);
      for (int i = 0; i < e.count; i++) {
        print('i = ' + i.toString());
        rawCollection.add(e);
      }
    });
    List<dynamic> json = rawCollection.map((e) => e.toExport()).toList();
    return FlutterClipboard.copy(json.toString()).then((value) => 0);
  }
}
