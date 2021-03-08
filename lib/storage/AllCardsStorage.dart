import 'dart:io';

import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/storage/Storage.dart';
import 'package:MagicFlutter/storage/file/FileManager.dart';

class AllCardsStorage extends Storage<MagicCard> {
  AllCardsStorage() : super('all_cards');

  void storeFromAssets() async {
    FileManager files = new FileManager();
    files.fromAssets().then((List<MagicCard> cards) {
      set(cards);
    });
  }

  Future<List<MagicCard>> get() async {
    dynamic allCards = await storage.getItem('cards');
    if (allCards == null)
      return [];
    else {
      return (allCards as List)
          ?.where((e) =>
              e['id'] != null ||
              (e['identifiers'] != null &&
              e['identifiers']['multiverseId'] != null))
          ?.map((dynamic item) {
        return new MagicCard.fromJson(item);
      })?.toList();
    }
  }

  void set(List<MagicCard> value) async {
    await storage.setItem('cards', value.map((e) => e.toJson()).toList());
  }

  void clear() {
    storage.clear();
  }
}
