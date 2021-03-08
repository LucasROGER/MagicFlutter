import 'dart:convert';

import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';

class FileManager {
  List<String> assets = [/*'STX', */'ZNR', 'KHM'];

  Future<List<MagicCard>> fromAssets() async {
    List<MagicCard> list = [];

    await assets.forEach((set) async {
      String data = (await rootBundle.loadString("assets/data/" + set + ".json")).replaceAll('†', '');
      final jsonResult = json.decode(data);
      List<dynamic> cardList = jsonResult['data']['cards'];
      await cardList.forEach((e) {
        list.add(new MagicCard.fromJson(e));
      });
    });
    return list;
  }
}
