import 'package:flutter/material.dart';

class MyDecksView extends StatefulWidget {
  MyDecksView({
    Key key,
  }) : super(key: key);

  @override
  _MyDecksViewState createState() => _MyDecksViewState();
}

class _MyDecksViewState extends State<MyDecksView> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
          itemCount: 0,
          itemBuilder: (BuildContext context, int index) {
            return;
          },
        ));
  }
}
