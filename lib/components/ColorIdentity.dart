import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:flutter/material.dart';

class ColorIdentity extends StatefulWidget {
  final double size;
  final MagicDeck deck;
  final MainAxisAlignment alignment;

  ColorIdentity({
    Key key,
    this.size,
    this.deck,
    this.alignment,
  }) : super(key: key);

  @override
  _ColorIdentityState createState() => _ColorIdentityState();
}

class _ColorIdentityState extends State<ColorIdentity> {
  List<Widget> getDeckItem() {
    List<Widget> colors = [];

    if (widget.deck.identity.length == 0) {
      colors.add(
        Center(
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Image(
              image: new AssetImage('assets/images/colors/C.png'),
              width: widget.size,
              height: widget.size,
            ),
          )
        )
      );
    }
    for (int i = 0; i < widget.deck.identity.length; i++) {
      colors.add(
        Center(
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Image(
              image: new AssetImage('assets/images/colors/' + widget.deck.identity[i] + '.png'),
              width: widget.size,
              height: widget.size,
            ),
          )
        )
      );
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.deck == null) return Container();
    return Row(
      mainAxisAlignment: widget.alignment,
      children: getDeckItem(),
    );
  }
}
