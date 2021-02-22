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
    this.size = 20,
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
    return Row(
      children: [
        !widget.disabled ? Text(
            '(',
            style: TextStyle(
              fontSize: 20,
              color: this.selected ? Colors.red : Colors.white,
            )
        ) : Container(),
        ActionItem(
          onTap: () {
            setState(() {
              this.selected = !this.selected;
            });
            widget.onTap(this.selected, widget.color);
          },
          item: Image(
            image: new AssetImage('assets/images/colors/' + widget.color + '.png'),
            width: widget.size,
            height: widget.size,
          ),
        ),
        !widget.disabled ? Text(
          ')',
          style: TextStyle(
            fontSize: 20,
            color: this.selected ? Colors.red : Colors.white,
          )
        ) : Container(),
      ],
    );
  }
}
