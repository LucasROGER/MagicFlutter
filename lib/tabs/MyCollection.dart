import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/data.dart';
import 'package:flutter/material.dart';

class MyCollectionView extends StatefulWidget {
  @override
  _MyCollectionViewState createState() => _MyCollectionViewState();
}

class _MyCollectionViewState extends State<MyCollectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: cardList == null ? 0 : cardList.length,
        itemBuilder: (BuildContext context, int index) {
          return ActionItem(
            callback: () {
              print(cardList[index]['name']);
            },
            item: Image(
              image: NetworkImage(
                  "https://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid=" +
                      cardList[index]['identifiers']['multiverseId']),
            ),
            menuCallbacks: [
              () {
                print("IOUI1");
              },
              () {
                print("IOUI2");
              },
              () {
                print("IOUI3");
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
          );
        },
      ),
    );
  }
}
