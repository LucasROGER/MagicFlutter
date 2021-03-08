import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/components/CardDialog.dart';
import 'package:MagicFlutter/components/DualList.dart';
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
  String directory;
  List file = new List();

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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SearchBar(list: this.allCards, updateFct: (newList) => setState((){this.newCards = newList;})),
              Expanded(
                child: DualList<MagicCard>(
                  list: this.newCards,
                  renderItem: (BuildContext context, int index, dynamic item) {
                    return Container(
                        padding: EdgeInsets.all(5),
                        child: ActionItem(
                          soundType: SoundType.Card,
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              // user must tap button!
                              builder: (BuildContext context) {
                                return CardDialog(
                                    item: item,
                                    addCallback: collectionStorage.addToCollection);
                              },
                            );
                          },
                          item: Image(
                            image: NetworkImage(
                                "https://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid=" +
                                    item.id),
                          ),
                          menuCallbacks: [
                                () {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return SelectDeckDialog(toAdd: item);
                                },
                              );
                            },
                                () {
                                  collectionStorage.addToCollection(item);
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
                        ));
                  },
                ),
              )
            ]));
  }
}
