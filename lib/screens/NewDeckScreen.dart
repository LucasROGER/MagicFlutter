import 'package:MagicFlutter/utils/DecksStorage.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/screens/base/Screen.dart';

class NewDeckScreen extends StatefulWidget {
  @override
  _NewDeckScreenState createState() => _NewDeckScreenState();
}

class _NewDeckScreenState extends State<NewDeckScreen> {
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
            ElevatedButton(
              onPressed: () {
                storage.createDeck(deckName.text, deckDescription.text);
                Navigator.of(context).pop(true);
              },
              child: Text('Create')
            ),
          ],
        ),
      )
    );
  }
}
