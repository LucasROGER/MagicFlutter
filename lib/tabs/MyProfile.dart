import 'dart:typed_data';

import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/TakePicture.dart';
import 'package:MagicFlutter/storage/CollectionStorage.dart';
import 'package:MagicFlutter/storage/DecksStorage.dart';
import 'package:MagicFlutter/storage/ProfileStorage.dart';
import 'package:MagicFlutter/storage/file/FileManager.dart';
import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MyProfileView extends StatefulWidget {
  final int id;

  MyProfileView({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyProfileView> {
  CollectionStorage cstorage = new CollectionStorage();
  DeckStorage dstorage = new DeckStorage();
  ProfileStorage pstorage = new ProfileStorage();
  FileManager files = new FileManager();
  int nbrDecks = 0;
  int nbrCards = 0;
  Uint8List profilePicture;

  void setup() async {
    List<MagicCard> list = await cstorage.get();
    int len = 0;

    for (int i = 0; i < list.length; i++) {
      len += list[i].count;
    }

    setState(() {
      this.nbrCards = len;
    });
    len = (await dstorage.get()).length;
    setState(() {
      this.nbrDecks = len;
    });
    Uint8List image = await pstorage.get();
    setState(() {
      this.profilePicture = image;
    });
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: Icon(
                                IconData(57364, fontFamily: 'MaterialIcons')),
                            tooltip: 'Take a new picture',
                            onPressed: () async {
                              WidgetsFlutterBinding.ensureInitialized();
                              final cameras = await availableCameras();
                              final firstCamera = cameras.first;

                              if (await Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return TakePictureScreen(
                                        camera: firstCamera);
                                  })) ==
                                  true) {
                                Uint8List img = await pstorage.get();
                                setState(() {
                                  this.profilePicture = img;
                                });
                              }
                            }),
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: CircleAvatar(
                              radius:
                                  ResponsiveSize.responsiveWidth(context, 30),
                              backgroundImage: profilePicture == null
                                  ? NetworkImage(
                                      "http://placekitten.com/150/150")
                                  : MemoryImage(profilePicture),
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(
                              IconData(57919, fontFamily: 'MaterialIcons')),
                          tooltip: 'Import from gallery',
                          onPressed: null,
                        ),
                      ),
                    ]),
                Column(children: <Text>[
                  Text('Number of decks: $nbrDecks'),
                  Text('Number of cards: $nbrCards')
                ]),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          TextButton(
                              child: Row(
                                children: [
                                  Icon(Icons.content_copy, color: Colors.white),
                                  Text("Collection",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              onPressed: () {
                                files.exportCollection().then((v) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(v == 0
                                                ? 'Collection copied to clipboard'
                                                : 'Collection can\'t be copied'),
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                              }),
                          TextButton(
                              child: Row(
                                children: [
                                  Icon(Icons.content_paste,
                                      color: Colors.white),
                                  Text("Collection",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              onPressed: () {
                                files.importCollection().then((v) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(v == 0
                                                ? 'Collection imported from clipboard'
                                                : 'Collection can\'t imported'),
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                              }),
                        ],
                      ),
                      Column(
                        children: [
                          TextButton(
                              child: Row(
                                children: [
                                  Icon(Icons.content_copy, color: Colors.white),
                                  Text("Decks",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              onPressed: () {
                                // files.exportDecks();
                              }),
                          TextButton(
                              child: Row(
                                children: [
                                  Icon(Icons.content_paste,
                                      color: Colors.white),
                                  Text("Decks",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              onPressed: () {
                                // files.exportDecks();
                              }),
                        ],
                      )
                    ],
                  ),
                ),
                TextButton(
                    child: Padding(
                        child: Text("Delete Application Data",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Are you sure?'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('This action is irreversible'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  cstorage.clear();
                                  dstorage.clear();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    })
              ]),
        )),
      ),
    );
  }
}
