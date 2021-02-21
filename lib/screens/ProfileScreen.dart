class ProfileScreen extends StatefulWidget {
  final int id;

  ProfileScreen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  int _nbrDecks = 0;
  int _nbrCards = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Profile")
      ),
      body: SafeArea(
        child: Container(
            width: double.infinity,
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                                IconData(57364, fontFamily: 'MaterialIcons')
                            ),
                            tooltip: 'Take a new picture',
                            onPressed: () async {
                              WidgetsFlutterBinding.ensureInitialized();
                              final cameras = await availableCameras();
                              final firstCamera = cameras.first;

                              Navigator.push(contect, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    return TakePictureScreen(
                                        camera: firstCamera
                                    );
                                  }
                              ))
                            },
                          ),
                          Container(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage('https://placekitten.com/200/200')
                              )
                          ),
                          IconButton(
                            icon: Icon(
                                IconData(57919, fontFamily: 'MaterialIcons')
                            ),
                            tooltip: 'Import from gallery',
                            onPressed: null,
                          ),
                        ]
                    ),
                    Column(
                        children: <Text>[
                          Text('Number of decks: $_nbrDecks'),
                          Text('Number of cards: $_nbrCards')
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
                        onPressed: () {}
                    )
                  ]
              ),
            )
        ),
      ),
    );
  }
}