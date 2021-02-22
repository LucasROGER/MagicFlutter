import 'package:MagicFlutter/tabs/AllCards.dart';
import 'package:MagicFlutter/tabs/MyCollection.dart';
import 'package:MagicFlutter/tabs/MyDecks.dart';
import 'package:MagicFlutter/tabs/MyProfile.dart';
import 'package:flutter/material.dart';

class NavigationBarWidget extends StatefulWidget {

    NavigationBarWidget({Key key}) : super(key: key);

    @override
    _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
    int selectedIndex = 0;
    List<String> pageNames = ["All cards", "My collection", "My decks", "My profile"];
    List<Widget> widgetOptions = <Widget>[
        AllCardsView(),
        MyCollectionView(),
        MyDecksView(),
        MyProfileView()
    ];

    void _onItemTapped(int index) {
        setState(() {
            selectedIndex = index;
        });
    }

    Widget defaultAppBar(BuildContext context) {
        return PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: AppBar(
                title: Text('Magic Flutter'),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey.shade50,
            resizeToAvoidBottomInset: false,
            appBar: defaultAppBar(context),
            body: Center(
                child: widgetOptions.elementAt(selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard_customize),
                        label: 'All Cards',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard),
                        label: 'My collection',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.class_),
                        label: 'My decks',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'My profile',
                    )
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Colors.redAccent,
                unselectedItemColor: Colors.grey.shade700,
                onTap: _onItemTapped,
            ),
            // floatingActionButton: SpeedDial(
                // marginRight: 18,
                // marginBottom: 20,
                // animatedIcon: AnimatedIcons.menu_close,
                // animatedIconTheme: IconThemeData(size: 22.0),
                // closeManually: false,
                // curve: Curves.bounceIn,
                // overlayColor: Colors.black,
                // overlayOpacity: 0.5,
                // backgroundColor: Colors.lightBlueAccent,
                // foregroundColor: Colors.white,
                // elevation: 8.0,
                // shape: CircleBorder(),
                // children: [
                //     SpeedDialChild(
                //         child: Icon(Icons.camera_alt),
                //         backgroundColor: Colors.lightBlueAccent,
                //         onTap: () async {
                //             var image = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);
                //
                //             Navigator.push(context, MaterialPageRoute(
                //                 builder: (context) => NewView(imageData: image)
                //             ));
                //         }
                //     ),
                //     SpeedDialChild(
                //         child: Icon(Icons.image),
                //         backgroundColor: Colors.lightBlueAccent,
                //         onTap: () async {
                //             var image = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                //
                //             Navigator.push(context, MaterialPageRoute(
                //                 builder: (context) => NewView(imageData: image)
                //             ));
                //         }
                //     )
                // ],
            // ),
        );
    }
}
