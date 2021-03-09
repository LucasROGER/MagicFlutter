import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/SearchBar.dart';
import 'package:MagicFlutter/components/filter/ColorFilter.dart';
import 'package:MagicFlutter/components/filter/Filter.dart';
import 'package:MagicFlutter/components/filter/SetFilter.dart';
import 'package:MagicFlutter/components/filter/TypeFilter.dart';
import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'CmcFilter.dart';

class CardFilters extends StatefulWidget {
  final List<MagicCard> allCards;
  final FilterUpdate<MagicCard> update;
  final bool searchBar;
  final bool colors;
  final bool cmcs;
  final bool types;
  final bool sets;

  CardFilters({
    Key key,
    this.allCards,
    this.update,
    this.searchBar = true,
    this.colors = true,
    this.cmcs = true,
    this.types = true,
    this.sets = true,
  }) : super(key: key);

  @override
  _CardFiltersState createState() => _CardFiltersState();
}

class _CardFiltersState extends State<CardFilters> {
  Map<String, List<MagicCard>> allList = new Map<String, List<MagicCard>>();
  List<double> costs = [];
  List<String> colors = [];
  List<String> types = [];
  List<String> sets = [];
  bool visible = true;

  List<MagicCard> _updateList() {
    List<MagicCard> res = [];

    for (int i = 0; i < widget.allCards.length; i++) {
      if (allList.values
              .where((element) => element.contains(widget.allCards[i]))
              .length ==
          allList.length) res.add(widget.allCards[i]);
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
    List<String> sets = [];

    for (int i = 0; i < widget.allCards.length; i++) {
      if (!costs.contains(widget.allCards[i].convertedManaCost))
        costs.add(widget.allCards[i].convertedManaCost);
      colors.addAll(widget.allCards[i].colorIdentity
          .where((element) => !colors.contains(element)));
      types.addAll(widget.allCards[i].types
          .where((element) => !types.contains(element)));
      if (!sets.contains(widget.allCards[i].setCode))
        sets.add(widget.allCards[i].setCode);
    }

    costs.sort();
    types.sort();

    setState(() {
      this.costs = costs;
      this.colors = colors;
      this.types = types;
      this.sets = sets;
    });
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CardFilters oldWidget) {
    if (oldWidget != widget) setup();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          // width: ResponsiveSize.responsiveWidth(context, 95),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 1))
            ],
          ),
          child: Column(
            children: [
              Visibility(
                  visible: this.visible,
                  child: Column(children: [
                    !widget.searchBar
                        ? Container()
                        : SearchBar(
                            list: widget.allCards,
                            updateFct: (List<dynamic> newList) {
                              allList['search'] = newList.cast<MagicCard>();
                              _update();
                            },
                          ),
                    !widget.cmcs
                        ? Container()
                        : CmcFilter(
                            costs: this.costs,
                            list: widget.allCards,
                            updateList: (List<dynamic> newList) {
                              // newList.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
                              allList['cmc'] = newList.cast<MagicCard>();
                              _update();
                            },
                          ),
                    !widget.sets
                        ? Container()
                        : SetFilter(
                      sets: this.sets,
                      list: widget.allCards,
                      updateList: (List<dynamic> newList) {
                        // newList.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
                        allList['set'] = newList.cast<MagicCard>();
                        _update();
                      },
                    ),
                    !widget.types
                        ? Container()
                        : TypeFilter(
                            types: this.types,
                            list: widget.allCards,
                            updateList: (List<dynamic> newList) {
                              // newList.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
                              allList['type'] = newList.cast<MagicCard>();
                              _update();
                            },
                          ),
                    !widget.colors
                        ? Container()
                        : ColorFilter(
                            colors: this.colors,
                            list: widget.allCards,
                            updateList: (List<dynamic> newList) {
                              // newList.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
                              allList['colors'] = newList.cast<MagicCard>();
                              _update();
                            },
                          ),
                  ])),
              Center(
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    onPressed: () {
                      setState(() {
                        this.visible = !this.visible;
                      });
                    },
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        children: [
                          Icon(
                            !this.visible
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            color: Colors.white,
                            size: ResponsiveSize.responsiveWidth(context, 5),
                          ),
                          // Image(
                          //   image: !this.visible
                          //       ? AssetImage('assets/images/arrow_down.png')
                          //       : AssetImage('assets/images/arrow_up.png'),
                          //
                          // ),
                          Text('Filters'),
                        ],
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
