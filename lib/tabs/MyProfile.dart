import 'dart:typed_data';

import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/utils/CollectionStorage.dart';
import 'package:MagicFlutter/utils/DecksStorage.dart';
import 'package:MagicFlutter/utils/ProfileStorage.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/TakePicture.dart';
import 'package:camera/camera.dart';
import 'package:MagicFlutter/utils/ResponsiveSize.dart';

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
                                    IconData(57364, fontFamily: 'MaterialIcons')
                                ),
                                tooltip: 'Take a new picture',
                                onPressed: () async {
                                  WidgetsFlutterBinding.ensureInitialized();
                                  final cameras = await availableCameras();
                                  final firstCamera = cameras.first;

                                  if (await Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return TakePictureScreen(
                                            camera: firstCamera
                                        );
                                      }
                                  )) == true) {
                                    Uint8List img = await pstorage.get();
                                    setState(() {
                                      this.profilePicture = img;
                                    });
                                  }
                                }
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: CircleAvatar(
                                  radius: ResponsiveSize.responsiveWidth(context, 30),
                                  backgroundImage: profilePicture == null ? NetworkImage("http://placekitten.com/150/150") : MemoryImage(profilePicture),
                                ),
                              )
                          ),

                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(
                                  IconData(57919, fontFamily: 'MaterialIcons')
                              ),
                              tooltip: 'Import from gallery',
                              onPressed: null,
                            ),
                          ),
                        ]
                    ),
                    Column(
                        children: <Text>[
                          Text('Number of decks: $nbrDecks'),
                          Text('Number of cards: $nbrCards')
                        ]
                    ),
                    TextButton(
                        child: Padding(
                            child: Text(
                                "Delete Application Data",
                                style: TextStyle(
                                  color: Colors.white,
                                )
                            ),
                            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                        ),
                        onPressed: () {
                          cstorage.clear();
                          dstorage.clear();
                        }
                    )
                  ]
              ),
            )
        ),
      ),
    );
  }
}