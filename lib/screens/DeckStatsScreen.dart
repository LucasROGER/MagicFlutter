import 'package:MagicFlutter/components/chart/TypesChart.dart';
import 'package:MagicFlutter/utils/Extensions.dart';
import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:MagicFlutter/screens/base/Screen.dart';
import 'package:MagicFlutter/storage/DecksStorage.dart';
import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/Title.dart' as Title;

class DeckStatsScreen extends StatefulWidget {
  final int id;

  DeckStatsScreen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _DeckStatsScreenState createState() => _DeckStatsScreenState();
}

class _DeckStatsScreenState extends State<DeckStatsScreen> {
  DeckStorage storage = new DeckStorage();
  MagicDeck deck;
  List<int> convertedManaCosts = [];
  Map<String, int> types = new Map<String, int>();

  void _getDeck() async {
    List<MagicDeck> decks = await storage.get();
    for (int i = 0; i < decks.length; i++) {
      if (decks[i].id == widget.id) {
        setState(() {
          this.deck = decks[i];
        });
        break;
      }
    }
  }

  List<Widget> getCardsType() {
    List<String> cardTypes = [];
    Map<String, int> t = new Map<String, int>();
    List<Widget> stats = [];

    stats.add(
      Title.Title(
        text: 'Card types',
      ),
    );

    stats.add(
      SizedBox(height: 10),
    );

    if (deck.cards.isEmpty) {
      stats.add(Text('No cards'));
      return stats;
    }

    for (int i = 0; i < deck.cards.length; i++) {
      cardTypes += (List.from(deck.cards[i].types).cast<String>()) * deck.cards[i].count;
    }

    while (cardTypes.isNotEmpty) {
      String type = cardTypes[0];
      t[type] = cardTypes.where((element) => element == type).length;
      cardTypes.removeWhere((e) => e == type);
    }

    t.forEach((key, value) {
      stats.add(
        Text('$key: $value')
      );
    });

    setState(() {
      this.types = t;
    });

    return stats;
  }

  List<BarChartGroupData> generateCmcBars() {
    List<BarChartGroupData> res = [];

    for (int i = 0; i < convertedManaCosts.length; i++) {
      res.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              y: double.parse(convertedManaCosts[i].toString()),
              colors: [Colors.orange, Colors.red],
              width: ResponsiveSize.responsiveWidth(context, 5),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                colors: [Color.fromARGB(255, 200, 200, 200), Colors.grey],
              ),
            )
          ],
        ),
      );
    }

    return res;
  }

  Widget getCmcChart() {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(convertedManaCosts[groupIndex].toString(), TextStyle());
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (double value) {
              return value.toInt().toString();
            },
            getTextStyles: (value) => TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Nunito'),
          ),
          leftTitles: SideTitles(
            showTitles: false,
            getTextStyles: (value) => TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Nunito'),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: generateCmcBars(),
      ),
    );
  }

  void _getCmcs() {
    List<int> cmcs = [];
    List<double> tmp = [];

    if (deck == null) return;
    for (int i = 0; i < deck.cards.length; i++) {
      if (!deck.cards[i].types.contains('Land')) {
        for (int j = 0; j < deck.cards[i].count; j++) {
          tmp.add(deck.cards[i].convertedManaCost);
        }
      }
    }

    int i = 0;
    while (tmp.isNotEmpty) {
      cmcs.add(tmp.where((element) => element == i).length);
      tmp.removeWhere((element) => element == i);
      i++;
    }

    setState(() {
      this.convertedManaCosts = cmcs;
    });
  }

  Future<void> _setup() async {
    await _getDeck();
    await _getCmcs();
  }

  @override
  initState() {
    _setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (this.deck == null) return Container();
    return Screen(
      title: 'Stats',
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          // ...getCardsType(),
          TypesChart(
            types: this.types,
          ),
          SizedBox(height: 50,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(ResponsiveSize.responsiveWidth(context, 10))),
              color: Color.fromARGB(40, 255, 30, 30),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  ResponsiveSize.responsiveWidth(context, 10),
                  ResponsiveSize.responsiveWidth(context, 5),
                  ResponsiveSize.responsiveWidth(context, 10),
                  ResponsiveSize.responsiveWidth(context, 5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Title.Title(text: 'CMCs'),
                  ),
                  SizedBox(height: 20,),
                  Text('Tap bars to see how many cards have this mana cost.'),
                  SizedBox(height: 20,),
                  Center(
                    child: getCmcChart(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
