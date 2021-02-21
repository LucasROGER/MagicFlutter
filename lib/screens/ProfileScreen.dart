class ProfileScreen extends StatefulWidget {
  final int id;

  ProfileScreen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

int _nbrDecks = 0;
int _nbrCards = 0;

class _ProfileScreenState extends State<ProfileScreen> {
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
                              width: 150,
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://placehold.it/50"
                                  ),
                                  radius: 50.0
                              )
                          ),
                          IconButton(
                            icon: Icon(
                                IconData(57919, fontFamily: 'MaterialIcons')
                            ),
                            tooltip: 'Import from gallery',
                            onPressed: () {

                            },
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
                            child: Text("Delete Application Data"),
                            padding: EdgeInsets.symetric(vertical: 5.0, horizontal: 10.0)
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                        ),
                        onPressed: null
                    )
                  ]
              ),
            )
        ),
      ),
    );
  }
}