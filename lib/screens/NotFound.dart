import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          children: [
            Text('Oops wrong page'),
            FlatButton(
              onPressed: () {

              },
              child: Text('Go to main page')
            )
          ],
        )
      ),
    );
  }
}
