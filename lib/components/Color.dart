import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MtgColor extends StatefulWidget {
  final double size;
  final String color;

  MtgColor({
    Key key,
    this.size = 7,
    this.color,
  }) : super(key: key);

  @override
  _MtgColorState createState() => _MtgColorState();
}

class _MtgColorState extends State<MtgColor> {
  @override
  Widget build(BuildContext context) {
    return Image(
      image: new AssetImage('assets/images/colors/' + widget.color + '.png'),
      width: ResponsiveSize.responsiveWidth(context, widget.size),
      height: ResponsiveSize.responsiveWidth(context, widget.size),
    );
  }
}
