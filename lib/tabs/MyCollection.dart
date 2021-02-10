import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/components/DualList.dart';
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
      child: DualList<dynamic>(
        list: cardList,
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
                  () {
                    print(item['manaCost']);
                  },
                  () {
                    print("2");
                  },
                  () {
                    print("3");
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
              ));
        },
      ),
    );
  }
}
