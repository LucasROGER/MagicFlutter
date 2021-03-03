import 'dart:convert';
import 'dart:io';

import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/components/CardDialog.dart';
import 'package:MagicFlutter/components/CardList.dart';
import 'package:MagicFlutter/components/DualList.dart';
import 'package:MagicFlutter/components/filter/CardFilters.dart';
import 'package:MagicFlutter/components/filter/CmcFilter.dart';
import 'package:MagicFlutter/components/filter/ColorFilter.dart';
import 'package:MagicFlutter/components/SearchBar.dart';
import 'package:MagicFlutter/components/SelectDeckDialog.dart';
import 'package:MagicFlutter/data.dart';
import 'package:MagicFlutter/utils/CollectionStorage.dart';
import 'package:MagicFlutter/utils/FileManager.dart';
import 'package:MagicFlutter/utils/SoundController.dart';
import 'package:flutter/material.dart';

class AllCardsView extends StatefulWidget {
  @override
  _AllCardsViewState createState() => _AllCardsViewState();
}

class _AllCardsViewState extends State<AllCardsView> {
  final CollectionStorage storage = new CollectionStorage();
  List<MagicCard> allCards = [];
  List<MagicCard> newCards = [];

  void _getAllCards() async {
    FileManager files = new FileManager();
    List<MagicCard> cards = await files.fromAssets();
    setState(() {
      this.allCards = cards;
      this.newCards = cards;
    });
  }

  @override
  initState() {
    _getAllCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardList(
        cards: this.allCards,
        onTapCard: (MagicCard item) {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return CardDialog(
                  item: item,
                  addCallback: storage.addToCollection
              );
            },
          );
        },
        menuCallbacks: [
          (MagicCard item) {
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              // user must tap button!
              builder: (BuildContext context) {
                return SelectDeckDialog(toAdd: item);
              },
            );
          },
          (MagicCard item) {
            storage.addToCollection(item);
          },
        ],
        menuItems: [
          PopupMenuItem(
            value: 0,
            child: Wrap(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.add_circle),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Add to a deck"),
                    )
                  ],
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: Wrap(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.add_circle),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Add to collection"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
