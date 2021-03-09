import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/utils/SoundController.dart';
import 'package:MagicFlutter/storage/Storage.dart';
import 'package:flutter/material.dart';

class CardDialog extends StatefulWidget {
  final MagicCard item;
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
  final SoundController sound = new SoundController();
  int count = 0;

  List<Widget> getActionButton() {
    List<Widget> list = [];
    if (widget.addCallback != null) {
      list.add(IconButton(
          icon: Icon(Icons.add_circle),
          enableFeedback: false,
          onPressed: () async {
            await sound.playSound(SoundType.AddCard);
            await widget.addCallback(widget.item);
            setState(() {
              this.count += 1;
            });
            await sound.playSound(SoundType.AddCard);
          }));
    }
    if (widget.removeOneCallback != null) {
      list.add(IconButton(
          icon: Icon(Icons.remove_circle),
          enableFeedback: false,
          onPressed: () async {
            await sound.playSound(SoundType.Click);
            await widget.removeOneCallback(widget.item);
            setState(() {
              this.count -= 1;
            });
            if (this.count <= 0) {
              Navigator.of(context).pop();
            }
          }));
    }
    if (widget.removeCallback != null) {
      list.add(IconButton(
          icon: Icon(Icons.delete),
          enableFeedback: false,
          onPressed: () async {
            await sound.playSound(SoundType.Click);
            await widget.removeCallback(widget.item);
            widget.item.count = 0;
            Navigator.of(context).pop();
          }));
    }
    list.add(MaterialButton(
      enableFeedback: false,
      child: Text('Dismiss', style: TextStyle(color: Theme.of(context).accentColor),),
      onPressed: () async {
        await sound.playSound(SoundType.Click);
        Navigator.of(context).pop();
      },
    ));
    return list;
  }

  @override
  void initState() {
    setState(() {
      this.count = widget.item.count;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.all(5),
        contentPadding: EdgeInsets.all(5),
        title: Text(
          widget.item.name + ' (' + this.count.toString() + ')',
          textAlign: TextAlign.center,
        ),
        content: Container(
          child: Image(
            fit: BoxFit.contain,
            image: NetworkImage(
                "https://gatherer.wizards.com/Handlers/Image.ashx?type=card&multiverseid=" +
                    widget.item.id),
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
        ),
        actions: getActionButton());
  }
}
