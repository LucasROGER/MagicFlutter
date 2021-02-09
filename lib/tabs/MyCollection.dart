import 'package:flutter/material.dart';

class MyCollectionView extends StatefulWidget {
  MyCollectionView({
    Key key,
  }) : super(key: key);

  @override
  _MyCollectionViewState createState() => _MyCollectionViewState();
}

class _MyCollectionViewState extends State<MyCollectionView> {

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
