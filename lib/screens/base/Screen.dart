import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  final String title;
  final Widget child;
  final EdgeInsets padding;

  Screen({
    Key key,
    this.title,
    this.child,
    this.padding = const EdgeInsets.all(10),
  }) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}
