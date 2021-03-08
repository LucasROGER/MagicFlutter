import 'package:MagicFlutter/screens/DeckScreen.dart';
import 'package:MagicFlutter/screens/DeckStatsScreen.dart';
import 'package:MagicFlutter/screens/NewDeckScreen.dart';
import 'package:MagicFlutter/screens/NotFound.dart';
import 'package:MagicFlutter/storage/AllCardsStorage.dart';
import 'package:MagicFlutter/storage/CollectionStorage.dart';
import 'package:MagicFlutter/storage/DecksStorage.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/NavigationBar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Navigation());
}

class Navigation extends StatelessWidget {
  final CollectionStorage collection = new CollectionStorage();
  final DeckStorage decks = new DeckStorage();
  final AllCardsStorage allCards = new AllCardsStorage();

  @override
  Widget build(BuildContext context) {
    allCards.storeFromAssets();
    decks.get();
    collection.get();

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

        // Handle '/deck/:id/stats'
        uri = Uri.parse(settings.name);
        if (uri.pathSegments.length == 3 &&
            uri.pathSegments.first == 'deck' &&
            uri.pathSegments.last == 'stats') {
          var id = int.parse(uri.pathSegments[1]);
          return MaterialPageRoute(
              builder: (context) => DeckStatsScreen(id: id));
        }


        return MaterialPageRoute(builder: (context) => NotFound());
      },
    );
  }
}


