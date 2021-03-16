import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/Title.dart' as Title;

const Map<String, Color> colors = {
  'W': Color(0xfffffbde),
  'U': Color(0xffb2e1f6),
  'B': Color(0xffd1cac7),
  'R': Color(0xfffebaa1),
  'G': Color(0xffa3d5b9),
};

class DevotionChart extends StatefulWidget {
  final Map<String, int> devotions;

  DevotionChart({
    Key key,
    this.devotions,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => DevotionChartState();
}

class DevotionChartState extends State<DevotionChart> {
  int touchedIndex;
  Map<String, double> devotions = new Map<String, double>();

  void setup() async {
    Map<String, double> tmp = new Map<String, double>();
    for (int i = 0; i < widget.devotions.length; i++) {
      tmp[widget.devotions.keys.elementAt(i)] = widget.devotions.values.elementAt(i).toDouble() / widget.devotions.values.map((e) => e).reduce((a, b) => a + b).toDouble();
    }
    await setState(() {
      this.devotions = tmp;
    });
  }

  @override
  void initState() {
    if (widget.devotions != null) {
      setup();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DevotionChart oldWidget) {
    if (oldWidget != widget) {
      setup();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(ResponsiveSize.responsiveWidth(context, 10))),
        color: Color.fromARGB(30, 30, 150, 30),
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveSize.responsiveWidth(context, 4)),
        child: Column(
          children: <Widget>[
            Title.Title(
              text: 'Devotions',
            ),
            SizedBox(
              height: 120,
            ),
            PieChart(
              PieChartData(
                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                    setState(() {
                      if (pieTouchResponse.touchInput is FlLongPressEnd ||
                          pieTouchResponse.touchInput is FlPanEnd) {
                        touchedIndex = -1;
                      } else {
                        touchedIndex = pieTouchResponse.touchedSectionIndex;
                      }
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: showingSections()),
            ),
            SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(this.devotions.length, (i) {
      print(this.devotions.values.elementAt(i));
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 18 : 14;
      final double radius = isTouched ? 120 : 110;
      final double percent = this.devotions[this.devotions.keys.elementAt(i)] * 100;

      return PieChartSectionData(
        color: Color(colors[this.devotions.keys.elementAt(i)].value),
        value: percent,
        title: (widget.devotions.values.reduce((a, b) => a + b) * this.devotions[this.devotions.keys.elementAt(i)]).toStringAsFixed(0),
        radius: radius,
        titleStyle: TextStyle(
          fontFamily: 'Nunito',
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    });
  }
}