import 'package:MagicFlutter/screens/base/Screen.dart';
import 'package:MagicFlutter/storage/DecksStorage.dart';
import 'package:MagicFlutter/utils/SoundController.dart';
import 'package:flutter/material.dart';

class NewDeckScreen extends StatefulWidget {
  @override
  _NewDeckScreenState createState() => _NewDeckScreenState();
}

class _NewDeckScreenState extends State<NewDeckScreen> {
  final SoundController sound = new SoundController();
  DeckStorage storage = new DeckStorage();
  TextEditingController deckName = new TextEditingController();
  TextEditingController deckDescription = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Screen(
        title: 'Create new deck',
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: deckName,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: deckDescription,
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: const OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              MaterialButton(
                  color: Theme.of(context).accentColor,
                  enableFeedback: false,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (deckName.text.length == 0) {
                      //TODO Error message
                      return;
                    }
                    await sound.playSound(SoundType.Validate);
                    storage.createDeck(deckName.text.trim(), deckDescription.text.trim());
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Create')),
            ],
          ),
        ));
  }
}
