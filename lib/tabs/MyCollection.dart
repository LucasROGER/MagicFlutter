import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:MagicFlutter/data.dart';

class MyCollectionView extends StatefulWidget {
  @override
  _MyCollectionViewState createState() => _MyCollectionViewState();
}

class _MyCollectionViewState extends State<MyCollectionView> {
  @override
  Widget build(BuildContext context) {
    print(cardList[0]["imageUrl"]);
    return Container(
        child: ListView.builder(
          itemCount: cardList == null ? 0 : cardList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Image(
              image: NetworkImage("https://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid=" + cardList[index]['identifiers']['multiverseId']),
            );
          },
        ));
  }
}
