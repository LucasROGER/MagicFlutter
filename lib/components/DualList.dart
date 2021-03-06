import 'package:flutter/material.dart';

typedef Widget RenderDualListItem<T>(BuildContext context, int i, T item);

class DualList<T> extends StatefulWidget {
  final List<T> list;
  final RenderDualListItem<T> renderItem;
  final RenderDualListItem<T> renderListItem;
  final bool displayList;

  DualList({
    Key key,
    this.list,
    this.renderItem,
    this.renderListItem,
    this.displayList = false,
  }) : super(key: key);

  @override
  _DualListState createState() => _DualListState();
}

class _DualListState<T> extends State<DualList<T>> {
  List<T> currentList = [];
  int _pageSize = 20;
  int _pageIndex = 1;
  bool isLoading = false;

  void _getFirstPage() {
    if (widget.list == null) return;
    List<T> tmp = widget.list.sublist(0, _pageSize >= widget.list.length
            ? (widget.list.length)
            : (_pageSize));
    setState(() {
      this.currentList = tmp;
    });
  }

  @override
  void didUpdateWidget(covariant DualList<T> oldWidget) {
    if (oldWidget != widget)
      _getFirstPage();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _getFirstPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent <=
          _scrollController.position.pixels) {
        if (!isLoading && _pageIndex * _pageSize < widget.list.length) {
          setState(() {
            this.isLoading = !this.isLoading;
          });
          List<T> tmp = new List.from(this.currentList);
          for (int i = _pageIndex * _pageSize;
              widget.list.length > i && i < (_pageIndex + 1) * _pageSize;
              i++) {
            tmp.add(widget.list[i]);
          }
          setState(() {
            this.currentList = tmp;
            this._pageIndex += 1;
            this.isLoading = !this.isLoading;
          });
        }
      }
    });

    if (currentList == null || currentList.length == 0) {
      return Container(
        color: Colors.white,
        margin: EdgeInsets.all(10),
        child: Container(
          child: Center(
            child: Text(
              'Empty',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(127, 127, 127, 127),
              ),
            ),
          ),
        ),
      );
    }
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(5),
      itemCount: currentList.length,
      itemBuilder: !widget.displayList ? (ctxt, i) {
        if (i.isOdd) return Container();
        if (currentList.length - i < 2)
          return _buildRow(
              widget.renderItem(ctxt, i, currentList[i]), Container());
        else
          return _buildRow(widget.renderItem(ctxt, i, currentList[i]),
              widget.renderItem(ctxt, i + 1, currentList[i + 1]));
      } : (ctxt, i) {
        return widget.renderListItem(ctxt, i, currentList[i]);
      }
    );
  }

  Widget _buildRow(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(
          child: left,
          flex: 1,
        ),
        Expanded(
          child: right,
          flex: 1,
        ),
      ],
    );
  }
}
