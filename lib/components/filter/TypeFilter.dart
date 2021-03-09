import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/filter/Filter.dart';

class TypeFilter extends StatefulWidget {
  final List<String> types;
  final List<MagicCard> list;
  final FilterUpdate<MagicCard> updateList;

  TypeFilter({
    Key key,
    this.types,
    this.list,
    this.updateList,
  }) : super(key: key);

  @override
  TypeFilterState createState() => TypeFilterState();
}

class TypeFilterState extends State<TypeFilter> {
  @override
  Widget build(BuildContext context) {
    return Filter<String, MagicCard>(
      filterValues: widget.types,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      buildItem: (dynamic value, int i) {
        return Image(
            image: AssetImage('assets/images/types/' + value.toLowerCase() + '.png'),
            width: ResponsiveSize.responsiveWidth(context, 7),
            height: ResponsiveSize.responsiveWidth(context, 7),
            color: Colors.black);
      },
      list: widget.list,
      condition: (dynamic value, dynamic item) {
        return (item.types.contains(value));
      },
      updateList: widget.updateList,
    );
  }
}
