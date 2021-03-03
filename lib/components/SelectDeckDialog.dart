import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:MagicFlutter/components/ColorIdentity.dart';
import 'package:MagicFlutter/components/MenuItem.dart';
import 'package:MagicFlutter/utils/DecksStorage.dart';
import 'package:MagicFlutter/utils/SoundController.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/utils/Extensions.dart';

class SelectDeckDialog extends StatefulWidget {
  final MagicCard toAdd;

  SelectDeckDialog({
    Key key,
    this.toAdd,
  }) : super(key: key);

  @override
  _SelectDeckDialogState createState() => _SelectDeckDialogState();
}

class _SelectDeckDialogState extends State<SelectDeckDialog> {
  final SoundController sound = new SoundController();
  final DeckStorage storage = new DeckStorage();
  List<MagicDeck> deckList = [];
  int nbToAdd = 1;

  void _getMyDecks() async {
    List<MagicDeck> decks = await storage.get();
    setState(() {
      this.deckList = decks;
    });
  }

  void selectDeck(MagicDeck deck) async {
    for (int i = 0; i < this.nbToAdd; i++)
      await storage.addToDeck(widget.toAdd, deck.id);
  }

  List<Widget> getDeckItem(MagicDeck deck) {
    List<Widget> colors = [];
    print(deck.identity);

    if (deck.identity.length == 0) {
      colors.add(
        Center(
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Image(
              image: new AssetImage('assets/images/colors/C.png'),
              width: 20,
              height: 20,
            ),
          )
        )
      );
    }
    for (int i = 0; i < deck.identity.length; i++) {
      if (deck.identity[i] == 'C') continue;
      colors.add(
        Center(
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Image(
              image: new AssetImage('assets/images/colors/' + deck.identity[i] + '.png'),
              width: 20,
              height: 20,
            ),
          )
        )
      );
    }
    colors.add(
      Center(
        child: Padding(
          padding: EdgeInsets.all(3),
            child: Text(
              deck.name,
              textAlign: TextAlign.center,
          ),
        )
      )
    );
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
        'Add ' + widget.toAdd.name,
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(16.0),
          itemCount: this.deckList.length,
          itemBuilder: (ctxt, i) {
            return MenuItem(
              onTap: () async {
                await sound.playSound(SoundType.Click);
                selectDeck(this.deckList[i]);
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(this.deckList[i].name.capitalize()),
                  ),
                  ColorIdentity(
                    size: 20,
                    deck: this.deckList[i],
                    alignment: MainAxisAlignment.start,
                  ),
                ],
              ),
            );
          }
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.remove_circle),
          onPressed: () {
            if (this.nbToAdd == 1) return;
            setState(() {
              this.nbToAdd -= 1;
            });
          }
        ),
        Text(this.nbToAdd.toString()),
        IconButton(
          icon: Icon(Icons.add_circle),
          onPressed: () {
            setState(() {
              this.nbToAdd += 1;
            });
          }
        ),
        TextButton(
          child: Text('Dismiss'),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
      ]
    );
  }
}
