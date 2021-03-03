import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/Cmc.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/filter/Filter.dart';

import '../Color.dart';

class CmcFilter extends StatefulWidget {
  final List<double> costs;
  final List<MagicCard> list;
  final FilterUpdate<MagicCard> updateList;

  CmcFilter({
    Key key,
    this.costs,
    this.list,
    this.updateList,
  }) : super(key: key);

  @override
  _CmcFilterState createState() => _CmcFilterState();
}

class _CmcFilterState extends State<CmcFilter> {
  @override
  Widget build(BuildContext context) {
    return Filter<double, MagicCard>(
      filterValues: widget.costs,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      buildItem: (dynamic value, i) {
        return Cmc(
          cmc: value,
          size: 6,
        );
      },
      list: widget.list,
      condition: (dynamic value, dynamic item) {
        return (item.convertedManaCost == value && item.id != null);
      },
      updateList: widget.updateList,
    );
  }
}
