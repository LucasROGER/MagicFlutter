import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/components/ColorIdentity.dart';
import 'package:MagicFlutter/utils/ResponsiveSize.dart';
import 'package:MagicFlutter/utils/SoundController.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/utils/Extensions.dart';

class Deck extends StatefulWidget {
  final Function onTap;
  final MagicDeck deck;

  Deck({
    Key key,
    this.onTap,
    this.deck,
  }) : super(key: key);

  @override
  _DeckState createState() => _DeckState();
}

class _DeckState extends State<Deck> {
  List<String> c = ['B', 'G', 'R', 'U', 'W'];
  double ratio = 1.41;
  double size = 40;

  String sort(String colors) {
    String res = '';

    if (colors == '') return 'C';

    for (int i = 0; i < c.length; i++) {
      if (colors.contains(c[i]))
        res += c[i];
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ActionItem(
        soundType: SoundType.Deck,
        onTap: widget.onTap,
        item: Container (
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF777777),
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(widget.deck == null ? 'Name' : widget.deck.name.capitalize()),
              widget.deck == null ? Container() : Image(
                image: AssetImage('assets/images/colors/identity/' + sort(widget.deck.identity) + '.jpg'),
                width: ResponsiveSize.responsiveWidth(context, size),
                height: ResponsiveSize.responsiveWidth(context, size * ratio),
                fit: BoxFit.fitHeight,
              ),
              ColorIdentity(
                alignment: MainAxisAlignment.center,
                deck: widget.deck,
                size: 20,
              )
            ],
          ),
        )
      )
    );
  }
}
