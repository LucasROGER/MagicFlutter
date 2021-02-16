import 'package:MagicFlutter/utils/DecksStorage.dart';
import 'package:MagicFlutter/utils/Storage.dart';
import 'package:flutter/material.dart';

class SelectDeckDialog extends StatefulWidget {
  final dynamic item;
  final storageCallback addCallback;
  final storageCallback removeOneCallback;
  final storageCallback removeCallback;

  SelectDeckDialog({
    Key key,
    this.item,
    this.addCallback,
    this.removeOneCallback,
    this.removeCallback,
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
          widget.item['name'] + ' (' + widget.item['count'].toString() + ')',
          textAlign: TextAlign.center,
        ),
        content: Container(
          child: Image(
            fit: BoxFit.contain,
            image: NetworkImage(
                "https://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid=" +
                    widget.item['identifiers']['multiverseId']),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {

              }),
          TextButton(
            child: Text('Dismiss'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]
    );
  }
}
