import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  final String title;
  final Widget child;
  final EdgeInsets padding;
  final List<Widget> actions;
  final FloatingActionButton floatingActionButton;

  Screen({
    Key key,
    this.title,
    this.actions,
    this.child,
    this.padding = const EdgeInsets.all(10),
    this.floatingActionButton,
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
        actions: widget.actions == null ? [] : widget.actions
      ),
      body: SafeArea(
          child: Padding(
            padding: widget.padding,
            child: widget.child,
          ),
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
