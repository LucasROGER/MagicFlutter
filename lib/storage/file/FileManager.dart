import 'dart:convert';

import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:flutter/services.dart';

class FileManager {
  List<String> assets = ['KHM', 'ZNR', 'M21', 'IKO', 'THB', 'ELD', 'M20', 'WAR', 'GRN', 'RNA', 'M19'];

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
}
