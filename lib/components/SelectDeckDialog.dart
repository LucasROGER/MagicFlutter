import 'package:MagicFlutter/utils/DecksStorage.dart';
import 'package:flutter/material.dart';

import 'ActionItem.dart';

class SelectDeckDialog extends StatefulWidget {
  var toAdd;

  SelectDeckDialog({
    Key key,
    this.toAdd,
  }) : super(key: key);

  @override
  _SelectDeckDialogState createState() => _SelectDeckDialogState();
}

class _SelectDeckDialogState extends State<SelectDeckDialog> {
  final DeckStorage storage = new DeckStorage();
  List deckList = [];

  void _getMyDecks() async {
    List decks = await storage.get();
    setState(() {
      this.deckList = decks;
    });
  }

  void selectDeck(deck) async {
    await storage.addToDeck(widget.toAdd, deck['id']);
  }

  List<Widget> getDeckItem(deck) {
    List<Widget> colors = [];
    for (int i = 0; i < deck['identity'].length; i++) {
      colors.add(Image(
          width: 10,
          height: 10,
          image: AssetImage(
              'assets/images/colors/' + deck['identity'][i] + '.png')));
    }
    colors.add(Text(deck['name']));
    return colors;
  }

  @override
  void initState() {
    _getMyDecks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.all(5),
        contentPadding: EdgeInsets.all(5),
        title: Text(
          'Add' + widget?.toAdd['name'],
          textAlign: TextAlign.center,
        ),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(16.0),
              itemCount: this.deckList.length,
              itemBuilder: (ctxt, i) {
                return ActionItem(
                  onTap: () {
                    selectDeck(this.deckList[i]);
                  },
                  item: Row(
                    children: getDeckItem(this.deckList[i]),
                  ),
                );
              }),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.remove_circle), onPressed: () {}),
          TextButton(
              child: Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ]);
  }
}
