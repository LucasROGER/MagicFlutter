import 'package:MagicFlutter/components/Title.dart' as Title;
import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/chart/Indicator.dart';

// import 'indicator.dart';

const colors = [0x77ff0000, 0x7700ff00, 0x770000ff, 0x77ffff00, 0x77ff00ff, 0x7700ffff, 0x77cdcdcd, 0x77454545];

class TypesChart extends StatefulWidget {
  final Map<String, int> types;

  TypesChart({
    Key key,
    this.types,
  }) : super(key: key);

  @override
  _TypesChartState createState() => _TypesChartState();
}

class _TypesChartState extends State<TypesChart> {
  int touchedIndex;
  Map<String, double> types = new Map<String, double>();

  void setup() {
    Map<String, double> tmp = new Map<String, double>();
    for (int i = 0; i < widget.types.length; i++) {
      tmp[widget.types.keys.elementAt(i)] = widget.types.values.elementAt(i).toDouble() / widget.types.values.map((e) => e).reduce((a, b) => a + b).toDouble();
    }
    setState(() {
      this.types = tmp;
    });
  }

  @override
  void initState() {
    if (widget.types != null) {
      setup();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TypesChart oldWidget) {
    if (oldWidget != widget) {
      setup();
    }
    super.didUpdateWidget(oldWidget);
  }

  List<Widget> getIndicators() {
    List<Widget> res = [];
    for (int i = 0; i < this.types.keys.length; i++) {
      res.add(
        Indicator(
          color: Color(colors[i]),
          text: this.types.keys.elementAt(i),
          isSquare: true,
        ),
      );
      res.add(
        SizedBox(
          height: 4,
        ),
      );
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    if (this.types.length == 0) return Container();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(ResponsiveSize.responsiveWidth(context, 10))),
        color: Color.fromARGB(40, 30, 30, 255),
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveSize.responsiveWidth(context, 4)),
        child: Column(
          children: <Widget>[
            Title.Title(
              text: 'Card Types',
            ),
            SizedBox(
              height: 120,
            ),
            Container(
              // height: 300,
              child: PieChart(
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
                  centerSpaceRadius: 40,
                  sections: showingSections()),
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...getIndicators(),
                // Indicator(
                //   color: Color(0xff0293ee),
                //   text: 'First',
                //   isSquare: true,
                // ),
                // SizedBox(
                //   height: 4,
                // ),
                // Indicator(
                //   color: Color(0xfff8b250),
                //   text: 'Second',
                //   isSquare: true,
                // ),
                // SizedBox(
                //   height: 4,
                // ),
                // Indicator(
                //   color: Color(0xff845bef),
                //   text: 'Third',
                //   isSquare: true,
                // ),
                // SizedBox(
                //   height: 4,
                // ),
                // Indicator(
                //   color: Color(0xff13d38e),
                //   text: 'Fourth',
                //   isSquare: true,
                // ),
                // SizedBox(
                //   height: 18,
                // ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    print('aze = ' + this.types.length.toString());
    return List.generate(this.types.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 18 : 14;
      final double radius = isTouched ? 80 : 70;
      final double percent = this.types[this.types.keys.elementAt(i)] * 100;

      return PieChartSectionData(
        color: Color(colors[i]),
        value: percent,
        title: percent.toStringAsFixed(1) + '%',
        radius: radius,
        titleStyle: TextStyle(
          fontFamily: 'Nunito',
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
      // switch (i) {
      //   case 0:
      //     return PieChartSectionData(
      //       color: const Color(0xff0293ee),
      //       value: 40,
      //       title: '40%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      //     );
      //   case 1:
      //     return PieChartSectionData(
      //       color: const Color(0xfff8b250),
      //       value: 30,
      //       title: '30%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      //     );
      //   case 2:
      //     return PieChartSectionData(
      //       color: const Color(0xff845bef),
      //       value: 15,
      //       title: '15%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      //     );
      //   case 3:
      //     return PieChartSectionData(
      //       color: const Color(0xff13d38e),
      //       value: 15,
      //       title: '15%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      //     );
      //   default:
      //     return null;
      // }
    });
  }
}