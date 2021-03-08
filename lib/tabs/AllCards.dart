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
import 'package:MagicFlutter/storage/AllCardsStorage.dart';
import 'package:MagicFlutter/storage/CollectionStorage.dart';
import 'package:MagicFlutter/storage/file/FileManager.dart';
import 'package:MagicFlutter/utils/SoundController.dart';
import 'package:flutter/material.dart';

class AllCardsView extends StatefulWidget {
  @override
  _AllCardsViewState createState() => _AllCardsViewState();
}

class _AllCardsViewState extends State<AllCardsView> {
  final CollectionStorage collectionStorage = new CollectionStorage();
  final AllCardsStorage storage = new AllCardsStorage();
  List<MagicCard> allCards = [];
  List<MagicCard> newCards = [];

  void _getAllCards() async {
    List<MagicCard> cards = await storage.get();
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
  void didUpdateWidget(covariant AllCardsView oldWidget) {
    if (oldWidget != widget) {
      _getAllCards();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (this.allCards.length == 0) return Container();
    return Container(
      child: CardList(
        cards: this.allCards,
        onTapCard: (dynamic item) {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return CardDialog(
                item: item,
                addCallback: collectionStorage.addToCollection
              );
            },
          );
        },
        menuCallbacks: <Function>[
          (dynamic item) {
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              // user must tap button!
              builder: (BuildContext context) {
                return SelectDeckDialog(toAdd: item);
              },
            );
          },
          (dynamic item) {
            collectionStorage.addToCollection(item);
          },
        ],
        menuItems: <PopupMenuEntry>[
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
