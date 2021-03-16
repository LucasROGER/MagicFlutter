import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/components/Cmc.dart';
import 'package:MagicFlutter/components/Color.dart';
import 'package:MagicFlutter/storage/CollectionStorage.dart';
import 'package:MagicFlutter/storage/DecksStorage.dart';
import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:MagicFlutter/utils/SoundController.dart';
import 'package:flutter/material.dart';

import 'ActionItem.dart';
import 'CardDialog.dart';
import 'DualList.dart';
import 'filter/CardFilters.dart';

typedef void TapCard(MagicCard card);

class CardList extends StatefulWidget {
  final List<MagicCard> cards;
  final bool searchBarFilter;
  final bool colorsFilter;
  final bool cmcsFilter;
  final bool typesFilter;
  final TapCard onTapCard;
  final List<PopupMenuEntry> menuItems;
  final List<Function> menuCallbacks;
  final bool displayList;

  CardList({
    Key key,
    this.cards,
    this.searchBarFilter = true,
    this.colorsFilter = true,
    this.cmcsFilter = true,
    this.typesFilter = true,
    this.onTapCard,
    this.menuItems,
    this.menuCallbacks,
    this.displayList = false,
  }) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  List<MagicCard> newCards = [];
  final CollectionStorage storage = new CollectionStorage();
  List<PopupMenuEntry> menuItems = [];
  List<Function> menuCallbacks = [];
  DeckStorage deckStorage = new DeckStorage();

  List<Widget> getManaCost(String manaCost) {
    List<Widget> res = [];
    if (manaCost == null) {
      return res;
    }
    RegExp x = RegExp('(\{[X]\})');
    RegExp colorless = RegExp('(\{[0-9*]\})');
    RegExp colors = RegExp('(\{[WUBRGC]\})');
    Iterable<RegExpMatch> list = colorless.allMatches(manaCost);
    Iterator<RegExpMatch> it = list.iterator;
    const double size = 6;

    while (it.moveNext()) {
      res.add(SizedBox(width: 2,));
      res.add(Cmc(
        size: size,
        cmc: double.parse(it.current.group(0).replaceAll('{', '').replaceAll('}', '')),
      ));
    }

    list = x.allMatches(manaCost);
    it = list.iterator;

    while (it.moveNext()) {
      res.add(SizedBox(width: 2,));
      res.add(Cmc(
        size: size,
      ));
    }

    list = colors.allMatches(manaCost);
    it = list.iterator;

    while (it.moveNext()) {
      res.add(SizedBox(width: 2,));
      res.add(MtgColor(
        size: size,
        color: it.current.group(0).replaceAll('{', '').replaceAll('}', ''),
      ));
    }

    return res;
  }

  void setup() {
    setState(() {
      this.menuItems = widget.menuItems;
      this.menuCallbacks = widget.menuCallbacks;
      this.newCards = widget.cards;
    });
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CardList oldWidget) {
    if (oldWidget != widget)
      setup();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CardFilters(
          allCards: widget.cards,
          update: (List<dynamic> newList) {
            setState(() {
              this.newCards = newList.cast<MagicCard>();
            });
          },
          searchBar: widget.searchBarFilter,
          colors: widget.colorsFilter,
          cmcs: widget.cmcsFilter,
          types: widget.typesFilter,
        ),
        Expanded(
          flex: 1,
          child: DualList<MagicCard>(
            list: this.newCards,
            displayList: widget.displayList,
            renderListItem: (BuildContext context, int index, dynamic item) {
              return Container(
                padding: EdgeInsets.all(3.75),
                child: ActionItem(
                  onTap: widget.onTapCard,
                  param: item,
                  item: Container(
                    width: ResponsiveSize.responsiveWidth(context, 100),
                    height: ResponsiveSize.responsiveHeight(context, 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 1))
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: Text(item.name == null ? '' : item.name.replaceAll(' // ', '\n')),
                            fit: BoxFit.fitHeight,
                          ),
                          Container(
                            child: Row(
                              children: [
                                ...getManaCost(item.manaCost),
                              ],
                            ),
                          ), // Text('data'),
                        ],
                      ),
                    )
                  ),
                  menuCallbacks: menuCallbacks,
                  menuItems: menuItems,
                ),
              );
            },
            renderItem: (BuildContext context, int index, dynamic item) {
              if (item == null) return Container();
              return Container(
                padding: EdgeInsets.all(5),
                child: ActionItem(
                  param: item,
                  soundType: SoundType.Card,
                  onTap: widget.onTapCard,
                  item: Stack(
                    children: [
                      Image(
                        image: NetworkImage(item.id == null ? 'http://placehold.it/210x297' :
                        "https://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid=" +
                            item.id
                        ),
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                      item.count == 0 ? Container() : Container(
                        child: Positioned(
                          bottom: 0,
                          left: 5,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                )
                              ],
                            ),
                            child: Text(
                              item.count.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            ),
                          )
                        )
                      )
                    ],
                  ),
                  menuCallbacks: menuCallbacks,
                  menuItems: menuItems,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
