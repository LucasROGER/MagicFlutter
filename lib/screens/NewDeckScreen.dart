import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewDeckScreen extends StatefulWidget {
  @override
  _NewDeckScreenState createState() => _NewDeckScreenState();
}

class _NewDeckScreenState extends State<NewDeckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child :Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Deck name'
                ),
              ),
              FlatButton(
                onPressed: () {
                  print('create deck');
                },
                child: Text('Create'),
              )
            ],
          ),
        )
      ),
    );
  }
}
