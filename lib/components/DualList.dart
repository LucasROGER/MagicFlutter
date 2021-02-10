import 'package:flutter/material.dart';
import 'package:MagicFlutter/components/Deck.dart';

class DualList extends StatefulWidget {
  final List<Deck> list;

  DualList({
    Key key,
    this.list
  }) : super(key: key);

  @override
  _DualListState createState() => _DualListState();
}

class _DualListState extends State<DualList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: widget.list.length,
        itemBuilder: (context, i) {
          if (i.isOdd) return Container();
          if (widget.list.length - i < 2)
            return _buildRow(widget.list[i], Container());
          else
            return _buildRow(widget.list[i], widget.list[i + 1]);
        });
  }

  Widget _buildRow(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left, flex: 1,),
        Expanded(child: right, flex: 1,),
      ],
    );
  }
}
