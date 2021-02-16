import 'dart:convert';

import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/components/CardDialog.dart';
import 'package:MagicFlutter/components/DualList.dart';
import 'package:MagicFlutter/screens/base/Screen.dart';
import 'package:MagicFlutter/utils/DecksStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DeckScreen extends StatefulWidget {
  final int id;

  DeckScreen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _DeckScreenState createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  DeckStorage storage = new DeckStorage();
  dynamic deck;
  List cardList;

  void _getDeckData() async {
    List allDecks = await storage.get();
    for (int i = 0; i < allDecks.length; i++) {
      if (allDecks[i]['id'] == widget.id) {
        var tmp = allDecks[i];
        setState(() {
          this.deck = tmp;
          this.cardList = jsonDecode(tmp['cards']);
        });
        break;
      }
    }
  }

  void _addToDeck(item) {
    storage.addToDeck(item, widget.id);
    _getDeckData();
  }

  void _removeDeck() {
    storage.removeDeck(widget.id);
    Navigator.of(context).pop();
  }

  void _removeOneToDeck(item) {
    storage.removeToDeck(item, widget.id);
    _getDeckData();
  }

  @override
  void initState() {
    _getDeckData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.delete),
          tooltip: 'Delete deck',
          onPressed: () {
            _removeDeck();
          },
        ),
      ],
      title: this.deck == null ? '' : this.deck['name'],
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, '/deck/' + widget.id.toString() + '/stats');
            },
            child: Text('See stats'),
          ),
          Expanded(
            flex: 1,
            child: DualList<dynamic>(
              list: cardList,
              renderItem: (BuildContext context, int index, dynamic item) {
                return Container(
                    padding: EdgeInsets.fromLTRB(
                        index % 2 != 0 ? 5 : 0, 5, index % 2 != 0 ? 0 : 5, 5),
                    child: ActionItem(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: true, // user must tap button!
                          builder: (BuildContext context) {
                            return CardDialog(
                              item: item,
                              addCallback: _addToDeck,
                              removeOneCallback: _removeOneToDeck,
                            );
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
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
