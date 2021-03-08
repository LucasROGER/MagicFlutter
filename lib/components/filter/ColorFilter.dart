import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/filter/Filter.dart';

import '../Color.dart';

class ColorFilter extends StatefulWidget {
  final List<String> colors;
  final List<MagicCard> list;
  final FilterUpdate<MagicCard> updateList;

  ColorFilter({
    Key key,
    this.colors,
    this.list,
    this.updateList,
  }) : super(key: key);

  @override
  _ColorFilterState createState() => _ColorFilterState();
}

class _ColorFilterState extends State<ColorFilter> {
  @override
  Widget build(BuildContext context) {
    return Filter<String, MagicCard>(
      filterValues: widget.colors,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      buildItem: (dynamic value, i) {
        return MtgColor(
          color: value,
          disabled: false,
        );
      },
      list: widget.list,
      condition: (dynamic value, dynamic item) {
        return (item.colorIdentity.contains(value));
      },
      updateList: widget.updateList,
    );
  }
}
