import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:MagicFlutter/components/ActionItem.dart';
import 'package:MagicFlutter/components/Color.dart';
import 'package:flutter/material.dart';

class ColorIdentity extends StatefulWidget {
  final double size;
  final MagicDeck deck;
  final MainAxisAlignment alignment;
  final bool disabled;
  final Function editCardView;

  ColorIdentity({
    Key key,
    this.size,
    this.deck,
    this.alignment,
    this.disabled = true,
    this.editCardView,
  }) : super(key: key);

  @override
  _ColorIdentityState createState() => _ColorIdentityState();
}

class _ColorIdentityState extends State<ColorIdentity> {
  String selectedColors;

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
      if (widget.deck.identity[i] == 'C') continue;
      colors.add(
        Center(
          child: Padding(
            padding: EdgeInsets.all(3),
            child: MtgColor(
              onTap: (bool selected, String color) {
                if (selected)
                  setState(() {
                    this.selectedColors += color;
                  });
                else {
                  setState(() {
                    this.selectedColors = this.selectedColors.replaceAll(color, '');
                  });
                }
                widget.editCardView(this.selectedColors);
              },
              color: widget.deck.identity[i],
              disabled: widget.disabled,
            )
          )
        ),
      );
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.deck == null) return Container();
    if (this.selectedColors == null) {
      setState(() {
        this.selectedColors = widget.deck.identity.toString();
      });
    }
    return Row(
      mainAxisAlignment: widget.alignment,
      children: getDeckItem(),
    );
  }
}
