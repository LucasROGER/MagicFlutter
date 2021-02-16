import 'package:MagicFlutter/screens/base/Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeckStatsScreen extends StatefulWidget {
  final int id;

  DeckStatsScreen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _DeckStatsScreenState createState() => _DeckStatsScreenState();
}

class _DeckStatsScreenState extends State<DeckStatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Stats',
      child: Container(),
    );
  }
}
