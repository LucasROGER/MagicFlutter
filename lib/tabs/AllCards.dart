import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/components/DualList.dart';
import 'package:MagicFlutter/components/SearchBar.dart';
import 'package:MagicFlutter/data.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

class AllCardsView extends StatefulWidget {
  @override
  _AllCardsViewState createState() => _AllCardsViewState();
}

class _AllCardsViewState extends State<AllCardsView> {
  final LocalStorage storage = new LocalStorage('my_collection');
  List allCards = [];

  @override
  void initState() {
    _getAllCards();
    super.initState();
  }

  void _getAllCards() {
    List allCardsList = cardList;
    allCardsList.map((item) {
      item['count'] = 0;
    });
    setState(() {
      this.allCards = allCardsList;
    });
  }

  void _saveToStorage(item) async {
    var myCards = await storage.getItem('cards');
    if (myCards == null) {
      myCards = [];
    }
    var newItem = item;
    int index = -1;
    bool found = false;
    for (int i = 0; i < myCards.length; i++) {
      if (myCards[i]['identifiers']['multiverseId'] ==
          newItem['identifiers']['multiverseId']) {
        newItem = myCards[i];
        found = true;
        index = i;
        break;
      }
    }
    if (index == -1 || found == false) {
      newItem['count'] = 1;
      myCards.add(newItem);
    } else {
      newItem['count'] += 1;
      myCards[index] = newItem;
    }
    await storage.setItem('cards', myCards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          SearchBar(),
          Expanded(
            child: DualList<dynamic>(
              list: allCards,
              renderItem: (BuildContext context, int index, dynamic item) {
                return Container(
                    padding: EdgeInsets.all(5),
                    child: ActionItem(
                      callback: () {
                        print(item['name']);
                      },
                      item: Image(
                        image: NetworkImage(
                            "https://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid=" +
                                item['identifiers']['multiverseId']),
                      ),
                      menuCallbacks: [
                        () {},
                        () {
                          _saveToStorage(item);
                        },
                        () {},
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
                                    child: Icon(Icons.visibility),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text("See full screen"),
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
                        PopupMenuItem(
                          value: 2,
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
                        )
                      ],
                    ));
              },
            ),
          )
        ]));
  }
}
