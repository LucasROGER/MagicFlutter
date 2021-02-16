import 'package:MagicFlutter/screens/CardScreen.dart';
import 'package:MagicFlutter/screens/DeckScreen.dart';
import 'package:MagicFlutter/screens/NewDeckScreen.dart';
import 'package:MagicFlutter/screens/NotFound.dart';
import 'package:MagicFlutter/tabs/AllCards.dart';
import 'package:MagicFlutter/tabs/MyCollection.dart';
import 'package:MagicFlutter/tabs/MyDecks.dart';
import 'package:MagicFlutter/tabs/MyProfile.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/NavigationBar.dart';

void main() => runApp(Navigation());

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MagicFlutter',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Nunito',
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => NavigationBarWidget());
        }

        // Handle '/deck/create'
        var uri = Uri.parse(settings.name);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'deck' &&
            uri.pathSegments.last == 'create') {
          return MaterialPageRoute(builder: (context) => NewDeckScreen());
        }

        // Handle '/deck/:id'
        uri = Uri.parse(settings.name);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'deck') {
          var id = int.parse(uri.pathSegments[1]);
          return MaterialPageRoute(builder: (context) => DeckScreen(id: id));
        }


        return MaterialPageRoute(builder: (context) => NotFound());
      },
    );
  }
}


