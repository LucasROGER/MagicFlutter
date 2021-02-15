import 'package:MagicFlutter/screens/CardScreen.dart';
import 'package:MagicFlutter/screens/DeckScreen.dart';
import 'package:MagicFlutter/screens/NotFound.dart';
import 'package:MagicFlutter/tabs/AllCards.dart';
import 'package:MagicFlutter/tabs/MyCollection.dart';
import 'package:MagicFlutter/tabs/MyDecks.dart';
import 'package:MagicFlutter/tabs/MyProfile.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/NavigationBar.dart';

void main() => runApp(MagicFlutter());

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => MagicFlutter());
        }

        // Handle '/card/:multiverseid'
        var uri = Uri.parse(settings.name);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'card') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => CardScreen(id: int.parse(id)));
        }

        // Handle '/deck/:id'
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'deck') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => DeckScreen(id: int.parse(id)));
        }

        // Handle '/deck/:id/stats
        if (uri.pathSegments.length == 3 &&
            uri.pathSegments.first == 'deck' &&
            uri.pathSegments.last == 'stats') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => CardScreen(id: int.parse(id)));
        }

        return MaterialPageRoute(builder: (context) => NotFound());
      }
    );
  }
}


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
