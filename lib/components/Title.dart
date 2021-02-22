import 'package:flutter/material.dart';

class Title extends StatefulWidget {
  final String text;

  Title({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  _TitleState createState() => _TitleState();
}

class _TitleState extends State<Title> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25,
      ),
    );
  }
}
