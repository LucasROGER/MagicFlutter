import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/components/CardDialog.dart';
import 'package:MagicFlutter/components/DualList.dart';
import 'package:MagicFlutter/utils/Storage.dart';
import 'package:flutter/material.dart';

class MyCollectionView extends StatefulWidget {
  @override
  _MyCollectionViewState createState() => _MyCollectionViewState();
}

class _MyCollectionViewState extends State<MyCollectionView> {
  final Storage storage = new Storage();
  List cardList = [];

  @override
  void initState() {
    _getMyCollection();
    super.initState();
  }

  void _getMyCollection() async {
    List myCards = await storage.collection.getItem('cards');
    if (myCards == null) {
      myCards = [];
    }
    setState(() {
      this.cardList = myCards;
    });
  }

  void _removeFromCollection(item) async {
    List myCards = await storage.removeFromCollection(item);
    setState(() {
      this.cardList = myCards;
    });
  }

  void _removeOneFromCollection(item) async {
    List myCards = await storage.removeOneFromCollection(item);
    setState(() {
      this.cardList = myCards;
    });
  }

  void _addOneFromCollection(item) async {
    List myCards = await storage.addOneToCollection(item);
    setState(() {
      this.cardList = myCards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DualList<dynamic>(
        list: cardList,
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
                          item: item,
                          addCallback: _addOneFromCollection,
                          removeOneCallback: _removeOneFromCollection,
                          removeCallback: _removeFromCollection);
                    },
                  );
                },
                item: new Stack(children: <Widget>[
                  new Image(
                    image: NetworkImage(
                        "https://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid=" +
                            item['identifiers']['multiverseId']),
                  ),
                  new Container(
                      child: new Positioned(
                          bottom: 0,
                          left: 5,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                )
                              ],
                            ),
                            child: Text(
                              item['count'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )))
                ]),
                menuCallbacks: [
                  () {},
                  () {
                    _addOneFromCollection(item);
                  },
                  () {
                    _removeOneFromCollection(item);
                  },
                  () {
                    _removeFromCollection(item);
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
                              child: Text("Add one"),
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
                              child: Icon(Icons.remove_circle),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text("Remove one"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Wrap(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.delete),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text("Remove from collection"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 4,
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
