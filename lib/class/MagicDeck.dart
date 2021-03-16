import 'package:MagicFlutter/class/MagicCard.dart';

class MagicDeck {
  String name;
  String description;
  List<MagicCard> cards;
  String identity;
  int id;

  MagicDeck({this.name, this.description, this.cards, this.identity, this.id});

  MagicDeck.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['cards'] != null) {
      cards = new List<MagicCard>();
      json['cards'].forEach((v) {
        cards.add(new MagicCard.fromJson(v));
      });
    }

    identity = json['identity'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.cards != null) {
      data['cards'] = this.cards.map((v) => v.toJson()).toList();
    }
    data['identity'] = this.identity;
    data['id'] = this.id;
    return data;
  }

  Map<String, dynamic> toExport() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\"name\"'] = '\"' + this.name + '\"';
    data['\"description\"'] = '\"' + this.description + '\"';
    List<MagicCard> deckCards = [];
    this.cards.forEach((e) {
      for (int i = 0; i <= e.count; i++) {
        deckCards.add(e);
      }
    });
    if (this.cards != null) {
      data['\"cards\"'] = deckCards.map((v) => v.toExport()).toList();
    }
    return data;
  }
}
