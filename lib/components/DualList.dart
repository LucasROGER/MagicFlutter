import 'package:flutter/material.dart';

typedef Widget RenderDualListItem<T>(BuildContext context, int i, T item);

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
    if (widget.list == null || widget.list.length == 0) {
      return Container(
        color: Colors.white,
        child: Container(
          child: Center(
            child: Text(
              'Empty',
              style: TextStyle(
                color: Color.fromARGB(127, 127, 127, 127),
              ),
            ),
          ),
        ),
      );
    }
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: widget.list.length,
        itemBuilder: (ctxt, i) {
          if (i.isOdd) return Container();
          if (widget.list.length - i < 2)
            return _buildRow(widget.renderItem(ctxt, i, widget.list[i]), Container());
          else
            return _buildRow(widget.renderItem(ctxt, i, widget.list[i]), widget.renderItem(ctxt, i + 1, widget.list[i + 1]));
        }
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
