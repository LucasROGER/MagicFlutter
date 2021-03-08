import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatefulWidget {
  final Function onTap;
  final Widget child;
  final bool selected;

  FilterItem({
    Key key,
    this.onTap,
    this.child,
    this.selected,
  }) : super(key: key);

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return ActionItem(
      onTap: widget.onTap,
      item: Opacity(
        opacity: widget.selected ? 1 : 0.3,
        child: widget.child,
      )
    );
  }
}
