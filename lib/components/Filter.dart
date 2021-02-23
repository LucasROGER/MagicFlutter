import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/FilterItem.dart';
import 'package:flutter/material.dart';

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

  Filter({
    Key key,
    this.mainAxisAlignment,
    this.filterValues,
    this.buildItem,
    this.condition,
    this.list,
    this.updateList,
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

    for (int i = 0; i < selected.length; i++) {
      if (!selected[i]) continue;
      res.addAll(widget.list.where((element) => widget.condition(widget.filterValues[i], element) && !res.contains(element)).toList());
    }

    return res;
  }

  void _buildItems() {
    print(selected);
    List<FilterContent<T>> res = new List<FilterContent<T>>();

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
          child: widget.buildItem(widget.filterValues[i], i),
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
    _buildItems();
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: this.widgets,
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