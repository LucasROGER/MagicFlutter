import 'package:flutter/material.dart';

class AllCardsView extends StatefulWidget {
  AllCardsView({
    Key key,
  }) : super(key: key);

  @override
  _AllCardsViewState createState() => _AllCardsViewState();
}

class _AllCardsViewState extends State<AllCardsView> {

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
