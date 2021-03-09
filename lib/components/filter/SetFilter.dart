import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/filter/Filter.dart';
import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:flutter/material.dart';

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
        return Image(
            image: AssetImage('assets/images/sets/' + value + '.png'),
            width: ResponsiveSize.responsiveWidth(context, 7),
            height: ResponsiveSize.responsiveWidth(context, 7),
            color: Colors.black);
      },
      list: widget.list,
      condition: (dynamic value, dynamic item) {
        return (item.setCode == value);
      },
      updateList: widget.updateList,
    );
  }
}
