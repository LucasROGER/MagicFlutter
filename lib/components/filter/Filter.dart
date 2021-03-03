import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/filter/FilterItem.dart';
import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef Widget FBuildItem<T>(T value, int index);
typedef bool FilterCondition<T,U>(T value, U item);
typedef void FilterUpdate<T>(List<T> list);

class Filter<T,U> extends StatefulWidget {
  final MainAxisAlignment mainAxisAlignment;
  final List<T> filterValues;
  final FBuildItem<T> buildItem;
  final FilterCondition<T,U> condition;
  final List<U> list;
  final FilterUpdate<U> updateList;
  final Function specialCase;

  Filter({
    Key key,
    this.mainAxisAlignment,
    this.filterValues,
    this.buildItem,
    this.condition,
    this.list,
    this.updateList,
    this.specialCase,
  }) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState<T,U> extends State<Filter<T,U>> {
  List<FilterContent<T>> filterContent;
  List<bool> selected;
  List<Widget> widgets;

  List<U> retrieveList() {
    List<U> res = [];

    if (widget.specialCase != null) {
      res.addAll(widget.list.where((element) => widget.specialCase(element) && !res.contains(element)));
    }

    for (int i = 0; i < selected.length; i++) {
      if (!selected[i]) continue;
      res.addAll(widget.list.where((element) => !res.contains(element) && widget.condition(widget.filterValues[i], element)));
    }

    return res;
  }

  void _buildItems() {
    List<FilterContent<T>> res = new List<FilterContent<T>>();

    if (widget.filterValues == null) return;
    for (int i = 0; i < widget.filterValues.length; i++) {
      res.add(new FilterContent<T>(
        FilterItem(
          onTap: () {
            List<bool> tmp = selected;
            tmp[i] = !tmp[i];
            setState(() {
              this.selected = tmp;
            });
            widget.updateList(retrieveList());
          },
          child: Container(
            child: widget.buildItem(widget.filterValues[i], i),
            margin: EdgeInsets.all(5),
          ),
          selected: selected[i],
        ),
        widget.filterValues[i]
      ));
    }



    List<Widget> w = [];
    for (int i = 0; i < res.length; i++) {
      w.add(res[i].widget);
    }

    setState(() {
      this.filterContent = res;
      this.widgets = w;
    });

  }

  void setup() {
    List<bool> s = [];

    for (int i = 0; i < widget.filterValues.length; i++) {
      s.add(true);
    }

    setState(() {
      this.selected = s;
    });
  }

  @override
  initState() {
    setup();
    setState(() {
      this.filterContent = new List<FilterContent<T>>();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.list.length);
    _buildItems();
    return SizedBox(
      height: ResponsiveSize.responsiveHeight(context, 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: this.widgets,
      )
    );
  }
}





class FilterContent<T> {
  FilterContent(FilterItem widget, T value) {
    this.widget = widget;
    this.value = value;
  }

  FilterItem widget;
  T value;
}