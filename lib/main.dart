import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/NavigationBar.dart';

void main() => runApp(MagicFlutter());

class MagicFlutter extends StatelessWidget {

  MagicFlutter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MagicFlutter',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: NavigationBarWidget()
    );
  }
}
