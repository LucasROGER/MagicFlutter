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
  var deck;
  List cardList;

  void _getCardList() async {
    List allDecks = await storage.get();
    for (int i = 0; i < allDecks.length; i++) {
      if (allDecks[i]['id'] == widget.id) {
        var tmp = allDecks[i];
        setState(() {
          this.deck = tmp;
          this.cardList = tmp['cards'];
        });
        break;
      }
    }
  }

  @override
  void initState() {
    _getCardList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
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
              renderItem: (ctxt, i, item) {
                return new Stack(children: <Widget>[
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
                ]);
              },
              list: this.cardList,
            ),
          )
        ],
      ),
    );
  }
}
