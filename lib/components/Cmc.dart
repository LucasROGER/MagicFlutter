import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:flutter/material.dart';

class Cmc extends StatefulWidget {
  final double cmc;
  final double size;

  Cmc({
    Key key,
    this.cmc = -1,
    this.size = 5,
  }) : super(key: key);

  @override
  _CmcState createState() => _CmcState();
}

class _CmcState extends State<Cmc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveSize.responsiveWidth(context, widget.size),
      height: ResponsiveSize.responsiveWidth(context, widget.size),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
        ),
        color: Color.fromARGB(255, 204, 194, 192),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(widget.cmc == -1 ? 'X' : widget.cmc.truncate().toString(),),
        ),
      ),
    );
  }
}
