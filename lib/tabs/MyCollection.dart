import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/CardDialog.dart';
import 'package:MagicFlutter/components/CardList.dart';
import 'package:MagicFlutter/components/SelectDeckDialog.dart';
import 'package:MagicFlutter/storage/CollectionStorage.dart';
import 'package:flutter/material.dart';

class MyCollectionView extends StatefulWidget {
  @override
  _MyCollectionViewState createState() => _MyCollectionViewState();
}

class _MyCollectionViewState extends State<MyCollectionView> {
  final CollectionStorage storage = new CollectionStorage();
  List<MagicCard> cardList = [];
  bool displayList = false;

  @override
  void initState() {
    _getMyCollection();
    super.initState();
  }

  void _getMyCollection() async {
    List<MagicCard> myCards = await storage.get();
    setState(() {
      this.cardList = myCards;
    });
  }

  void _removeFromCollection(MagicCard item) async {
    List<MagicCard> myCards = await storage.removeFromCollection(item);
    setState(() {
      this.cardList = myCards;
    });
  }

  void _removeOneFromCollection(MagicCard item) async {
    List<MagicCard> myCards = await storage.removeOneFromCollection(item);
    setState(() {
      this.cardList = myCards;
    });
  }

  void _addOneFromCollection(MagicCard item) async {
    List<MagicCard> myCards = await storage.addOneToCollection(item);
    setState(() {
      this.cardList = myCards;
    });
  }

  @override
  void didUpdateWidget(covariant MyCollectionView oldWidget) {
    if (oldWidget != widget) {
      _getMyCollection();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (cardList.length == 0) return Container();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            this.displayList = !this.displayList;
          });
        },
        child: Icon(!this.displayList ? Icons.grid_view : Icons.list),
      ),
      body: CardList(
        displayList: this.displayList,
        cards: this.cardList,
        onTapCard: (dynamic item) {
          showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button!
            builder: (BuildContext context) {
              return CardDialog(
                item: item,
                addCallback: _addOneFromCollection,
                removeOneCallback: _removeOneFromCollection,
                removeCallback: _removeFromCollection
              );
            },
          );
        },
        menuCallbacks: [
          (dynamic item) {
            showDialog<void>(
              context: context,
              barrierDismissible: true, // user must tap button!
              builder: (BuildContext context) {
                return SelectDeckDialog(toAdd: item);
              },
            );
          },
          (dynamic item) {
            _addOneFromCollection(item);
          },
          (dynamic item) {
            _removeOneFromCollection(item);
          },
          (dynamic item) {
            _removeFromCollection(item);
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
        ],
      ),
      /*child: DualList<MagicCard>(
        list: cardList,
        renderItem: (BuildContext context, int index, dynamic item) {
          return Container(
            padding: EdgeInsets.all(5),
            child: ActionItem(
              soundType: SoundType.Card,
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
                          item.id),
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
                            item.count.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )))
              ]),
              menuCallbacks: [

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
              ],
            ));
        },
      ),*/
    );
  }
}
