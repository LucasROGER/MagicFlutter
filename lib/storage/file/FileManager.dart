import 'dart:convert';

import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:MagicFlutter/storage/AllCardsStorage.dart';
import 'package:MagicFlutter/storage/CollectionStorage.dart';
import 'package:MagicFlutter/storage/DecksStorage.dart';
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
      print(set);
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
      try {
        AllCardsStorage storage = new AllCardsStorage();
        CollectionStorage collectionStorage = new CollectionStorage();
        List<MagicCard> allCards = await storage.get();
        List jsonList = jsonDecode(value);
        if (jsonList == null) return -1;
        for (int j = 0; j < jsonList.length - 1; j++) {
          for (int i = 0; i < allCards.length - 1; i++) {
            if (jsonList[j]['id'] == null) return -1;
            if (allCards[i].id == jsonList[j]['id']) {
              var cards = await collectionStorage.addOneToCollection(allCards[i]);
            }
          }
        }
        return 0;
      } catch (e) {
        print(e);
        return -1;
      }
    });
  }

  Future<int> exportCollection() async {
    CollectionStorage collectionStorage = new CollectionStorage();
    List<MagicCard> collection = await collectionStorage.get();
    List<MagicCard> rawCollection = [];
    collection.forEach((e) {
      for (int i = 0; i <= e.count; i++) {
        rawCollection.add(e);
      }
    });
    List<dynamic> json = rawCollection.map((e) => e.toExport()).toList();
    return FlutterClipboard.copy(json.toString()).then((value) => 0);
  }

  Future<int> importDecks() async {
    return await FlutterClipboard.paste().then((value) async {
      if (value == null) return -1;
      try {
        DeckStorage deckStorage = new DeckStorage();
        AllCardsStorage storage = new AllCardsStorage();
        List<dynamic> jsonList = jsonDecode(value);
        if (jsonList == null) return -1;
        List<MagicCard> allCards = await storage.get();
        for (int j = 0; j < jsonList.length; j++) {
          if (jsonList[j]['name'] == null) return -1;
          deckStorage
              .createDeck(
                  jsonList[j]['name'],
                  jsonList[j]['description'] == null
                      ? ''
                      : jsonList[j]['description'])
              .then((id) async {
            List cardList = jsonList[j]['cards'];
            for (int i = 0; i < cardList.length - 1; i++) {
              if (cardList[i]['id'] == null) return -1;
              for (int k = 0; k < allCards.length - 1; k++) {
                if (allCards[k].id == cardList[i]['id']) {
                  var deck = await deckStorage.addToDeck(allCards[k], id);
                }
              }
            }
          });
        }
        return 0;
      } catch (e) {
        print(e);
        return -1;
      }
    });
  }

  Future<int> exportDecks() async {
    DeckStorage deckStorage = new DeckStorage();
    List<MagicDeck> allDecks = await deckStorage.get();
    List<dynamic> json = allDecks.map((e) => e.toExport()).toList();
    return FlutterClipboard.copy(json.toString()).then((value) => 0);
  }
}
