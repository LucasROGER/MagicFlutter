import 'dart:convert';

import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';

class FileManager {
  List<String> assets = ['ZNR', 'KHM'];

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
}
