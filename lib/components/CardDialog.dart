import 'package:MagicFlutter/utils/Storage.dart';
import 'package:flutter/material.dart';

class CardDialog extends StatefulWidget {
  final dynamic item;
  final storageCallback addCallback;
  final storageCallback removeOneCallback;
  final storageCallback removeCallback;

  CardDialog({
    Key key,
    this.item,
    this.addCallback,
    this.removeOneCallback,
    this.removeCallback,
  }) : super(key: key);

  @override
  _CardDialogState createState() => _CardDialogState();
}

class _CardDialogState extends State<CardDialog> {
  int count = 0;

  List<Widget> getActionButton() {
    List<Widget> list = [];
    if (widget.addCallback != null) {
      list.add(IconButton(
          icon: Icon(Icons.add_circle),
          onPressed: () {
            widget.addCallback(widget.item);
            setState(() {
              this.count += 1;
            });
          }));
    }
    if (widget.removeOneCallback != null) {
      list.add(IconButton(
          icon: Icon(Icons.remove_circle),
          onPressed: () {
            widget.removeOneCallback(widget.item);
            setState(() {
              this.count -= 1;
            });
            if (widget.item['count'] - 1 <= 0) {
              Navigator.of(context).pop();
            }
          }));
    }
    if (widget.removeCallback != null) {
      list.add(IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            widget.removeCallback(widget.item);
            widget.item['count'] = 0;
            Navigator.of(context).pop();
          }));
    }
    list.add(TextButton(
      child: Text('Dismiss'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ));
    return list;
  }

  @override
  void initState() {
    setState(() {
      this.count = widget.item['count'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.all(5),
        contentPadding: EdgeInsets.all(5),
        title: Text(
          widget.item['name'] + ' (' + widget.item['count'].toString() + ')',
          textAlign: TextAlign.center,
        ),
        content: Container(
          child: Image(
            fit: BoxFit.contain,
            image: NetworkImage(
                "https://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid=" +
                    widget.item['identifiers']['multiverseId']),
          ),
        ),
        actions: getActionButton());
  }
}
