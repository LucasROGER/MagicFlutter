import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/components/CardDialog.dart';
import 'package:MagicFlutter/components/DualList.dart';
import 'package:MagicFlutter/data.dart';
import 'package:MagicFlutter/utils/Storage.dart';
import 'package:flutter/material.dart';

class AllCardsView extends StatefulWidget {
  @override
  _AllCardsViewState createState() => _AllCardsViewState();
}

class _AllCardsViewState extends State<AllCardsView> {
  final Storage storage = new Storage();
  List allCards = [];

  void _getAllCards() async {
    List myCards = await storage.collection.getItem('cards');
    if (myCards == null) {
      myCards = [];
    }
    List allCardsList = [];
    for (int i = 0; i < cardList.length; i++) {
      bool found = false;
      for (int j = 0; j < myCards.length; j++) {
        if (myCards[j]['identifiers']['multiverseId'] ==
            cardList[i]['identifiers']['multiverseId']) {
          cardList[i]['count'] = myCards[j]['count'];
          found = true;
        }
      }
      ;
      if (found == false) {
        cardList[i]['count'] = 0;
      } else {
        found = false;
      }
      allCardsList.add(cardList[i]);
    }
    setState(() {
      this.allCards = allCardsList;
    });
  }

  @override
  initState() {
    _getAllCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DualList<dynamic>(
        list: this.allCards,
        renderItem: (BuildContext context, int index, dynamic item) {
          return Container(
              padding: EdgeInsets.all(5),
              child: ActionItem(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true, // user must tap button!
                    builder: (BuildContext context) {
                      return CardDialog(
                          item: item, addCallback: storage.addToCollection);
                    },
                  );
                },
                item: Image(
                  image: NetworkImage(
                      "https://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid=" +
                          item['identifiers']['multiverseId']),
                ),
                menuCallbacks: [
                  () {},
                  () {
                    storage.addToCollection(item);
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
    );
  }
}
