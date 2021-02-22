import 'package:flutter/material.dart';

class ActionItem extends StatefulWidget {
  final Widget item;
  final List<PopupMenuEntry> menuItems;
  final List<Function> menuCallbacks;
  final Function onTap;

  ActionItem({Key key, this.item, this.menuItems, this.menuCallbacks, this.onTap})
      : super(key: key);

  @override
  _ActionItemState createState() => _ActionItemState();
}

class _ActionItemState extends State<ActionItem> {
  var _tapPosition;

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  Future<void> _showCustomMenu() async {
    if (widget.menuItems == null)  return;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    final index = await showMenu(
        context: context,
        items: widget.menuItems,
        position: RelativeRect.fromRect(
            _tapPosition & const Size(40, 40), // smaller rect, the touch area
            Offset.zero & overlay.size // Bigger rect, the entire screen
            ));
    if (index == null) {
      return;
    }
    widget.menuCallbacks[index]();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        onLongPress: _showCustomMenu,
        onTapDown: _storePosition,
        child: widget.item);
  }
}
