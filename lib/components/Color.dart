import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:flutter/rendering.dart';

class MtgColor extends StatefulWidget {
  final double size;
  final Function onTap;
  final String color;
  final bool disabled;

  MtgColor({
    Key key,
    this.size = 7,
    this.onTap,
    this.color,
    this.disabled = true,
  }) : super(key: key);

  @override
  _MtgColorState createState() => _MtgColorState();
}

class _MtgColorState extends State<MtgColor> {
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: selected ? 1 : 0.3,
      child: Image(
        image: new AssetImage('assets/images/colors/' + widget.color + '.png'),
        width: ResponsiveSize.responsiveWidth(context, widget.size),
        height: ResponsiveSize.responsiveWidth(context, widget.size),
      ),
    );
  }
}
