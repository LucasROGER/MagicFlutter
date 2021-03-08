import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/filter/Filter.dart';

import '../Color.dart';

class SetFilter extends StatefulWidget {
  final List<String> sets;
  final List<MagicCard> list;
  final FilterUpdate<MagicCard> updateList;

  SetFilter({
    Key key,
    this.sets,
    this.list,
    this.updateList,
  }) : super(key: key);

  @override
  _SetFilterState createState() => _SetFilterState();
}

class _SetFilterState extends State<SetFilter> {
  @override
  Widget build(BuildContext context) {
    return Filter<String, MagicCard>(
      filterValues: widget.sets,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      buildItem: (dynamic value, i) {
        return Text(value);
      },
      list: widget.list,
      condition: (dynamic value, dynamic item) {
        return (item.setCode == value);
      },
      updateList: widget.updateList,
    );
  }
}
