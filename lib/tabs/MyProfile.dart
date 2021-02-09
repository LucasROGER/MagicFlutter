import 'package:flutter/material.dart';

class MyProfileView extends StatefulWidget {
  MyProfileView({
    Key key,
  }) : super(key: key);

  @override
  _MyProfileViewState createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {

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
