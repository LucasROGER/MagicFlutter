import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  final Function onTap;
  final Widget child;

  MenuItem({
    Key key,
    this.onTap,
    this.child,
  }) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return ActionItem(
      onTap: widget.onTap,
      item: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0x66FF0000),
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: widget.child,
      )
    );
  }
}
