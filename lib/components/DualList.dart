import 'package:flutter/material.dart';

typedef Widget RenderDualListItem(BuildContext context, int i, Widget item);

class DualList<T> extends StatefulWidget {
  final List<T> list;
  final RenderDualListItem renderItem;

  DualList({
    Key key,
    this.list,
    this.renderItem,
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
        itemBuilder: (ctxt, i) => widget.renderItem(ctxt, i, widget.list[i]),
    );
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
