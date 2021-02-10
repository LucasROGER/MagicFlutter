import 'package:flutter/material.dart';

class Deck extends StatefulWidget {
  @override
  _DeckState createState() => _DeckState();
}

class _DeckState extends State<Deck> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container (
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('name'),
            Image.network('http://placehold.it/210x297')
          ],
        ),
      )
    );
  }
}
