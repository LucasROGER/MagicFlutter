import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/SearchBar.dart';
import 'package:MagicFlutter/components/filter/Filter.dart';
import 'package:MagicFlutter/data.dart';
import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/filter/ColorFilter.dart';
import 'package:MagicFlutter/components/filter/TypeFilter.dart';
import 'package:flutter/rendering.dart';

import 'CmcFilter.dart';

class CardFilters extends StatefulWidget {
  final List<MagicCard> allCards;
  final FilterUpdate<MagicCard> update;
  final bool searchBar;
  final bool colors;
  final bool cmcs;
  final bool types;

  CardFilters({
    Key key,
    this.allCards,
    this.update,
    this.searchBar = true,
    this.colors = true,
    this.cmcs = true,
    this.types = true,
  }) : super(key: key);

  @override
  _CardFiltersState createState() => _CardFiltersState();
}

class _CardFiltersState extends State<CardFilters> {
  Map<String, List<MagicCard>> allList = new Map<String, List<MagicCard>>();
  List<double> costs = [];
  List<String> colors = [];
  List<String> types = [];
  bool visible = true;

  List<MagicCard> _updateList() {
    List<MagicCard> res = [];

    for (int i = 0; i < widget.allCards.length; i++) {
      if (allList.values.where((element) => element.contains(widget.allCards[i])).length == allList.length)
        res.add(widget.allCards[i]);
      // res.addAll(allList[allList.keys.toList()[i]].where((element) => !res.contains(element)));
    }

    res.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
    return res;
  }

  void _update() {
    widget.update(_updateList());
  }

  void setup() {
    List<double> costs = [];
    List<String> colors = [];
    List<String> types = [];

    for (int i = 0; i < widget.allCards.length; i++) {
      if (!costs.contains(widget.allCards[i].convertedManaCost))
        costs.add(widget.allCards[i].convertedManaCost);
      colors.addAll(widget.allCards[i].colorIdentity.where((element) => !colors.contains(element)));
      types.addAll(widget.allCards[i].types.where((element) => !types.contains(element)));
    }

    costs.sort();
    types.sort();

    setState(() {
      this.costs = costs;
      this.colors = colors;
      this.types = types;
    });
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CardFilters oldWidget) {
    if (oldWidget != widget)
      setup();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: FlatButton(
            onPressed: () {
              setState(() {
                this.visible = !this.visible;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: this.visible ? AssetImage('assets/images/arrow_down.png') : AssetImage('assets/images/arrow_up.png'),
                  width: ResponsiveSize.responsiveWidth(context, 5),
                  height: ResponsiveSize.responsiveWidth(context, 5),
                ),
                Text(' Filters'),
              ],
            )
          ),
        ),
        Visibility(
          visible: this.visible,
            child: Column(
              children: [
                !widget.searchBar ? Container() : SearchBar(
                  list: widget.allCards,
                  updateFct: (List<dynamic> newList) {
                    allList['search'] = newList.cast<MagicCard>();
                    _update();
                  },
                ),
                !widget.colors ? Container() : ColorFilter(
                  colors: this.colors,
                  list: widget.allCards,
                  updateList: (List<dynamic> newList) {
                    // newList.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
                    allList['colors'] = newList.cast<MagicCard>();
                    _update();
                  },
                ),
                  !widget.cmcs ? Container() : CmcFilter(
                    costs: this.costs,
                    list: widget.allCards,
                    updateList: (List<dynamic> newList) {
                      // newList.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
                      allList['cmc'] = newList.cast<MagicCard>();
                      _update();
                    },
                  ),
                  !widget.types ? Container() : TypeFilter(
                    types: this.types,
                    list: widget.allCards,
                    updateList: (List<dynamic> newList) {
                      // newList.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
                      allList['type'] = newList.cast<MagicCard>();
                      _update();
                    },
                  ),
              ]
            )
        ),
      ],
    );
  }
}
