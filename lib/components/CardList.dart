import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/utils/CollectionStorage.dart';
import 'package:MagicFlutter/utils/SoundController.dart';
import 'package:flutter/material.dart';

import 'ActionItem.dart';
import 'CardDialog.dart';
import 'DualList.dart';
import 'SelectDeckDialog.dart';
import 'filter/CardFilters.dart';

class CardList extends StatefulWidget {
  final List<MagicCard> cards;
  final bool searchBarFilter;
  final bool colorsFilter;
  final bool cmcsFilter;
  final bool typesFilter;
  final Function onTapCard;
  final List<PopupMenuEntry> menuItems;
  final List<Function> menuCallbacks;

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
  }) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  List<MagicCard> newCards = [];
  final CollectionStorage storage = new CollectionStorage();
  List<PopupMenuEntry> menuItems = [];
  List<Function> menuCallbacks = [];

  @override
  void initState() {
    setState(() {
      this.menuItems = widget.menuItems;
      this.menuCallbacks = widget.menuCallbacks;
      this.newCards = widget.cards;
    });
    super.initState();
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
          child: DualList<MagicCard>(
            list: this.newCards,
            renderItem: (BuildContext context, int index, dynamic item) {
              if (item == null) return Container();
              return Container(
                padding: EdgeInsets.all(5),
                child: ActionItem(
                  soundType: SoundType.Card,
                  onTap: widget.onTapCard,
                  item: Image(
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
                  menuCallbacks: menuCallbacks,
                  menuItems: menuItems,
                )
              );
            },
          ),
        )
      ],
    );
  }
}
