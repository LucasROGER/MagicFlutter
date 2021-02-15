import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Text('Oops wrong page'),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go to main page')
            )
          ],
        )
      ),
    );
  }
}
