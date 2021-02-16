import 'package:flutter/material.dart';

class MagicCard {
  List<String> colorIdentity;
  int convertedManaCost;
  String id;
  String manaCost;
  String name;
  String number;
  String originalText;
  String originalType;
  String power;
  PurchaseUrls purchaseUrls;
  String rarity;
  String setCode;
  List<String> subtypes;
  List<String> supertypes;
  String text;
  String toughness;
  String type;
  List<String> types;
  String uuid;
  int count;

  MagicCard(
      {
        this.colorIdentity,
        this.convertedManaCost,
        this.id,
        this.manaCost,
        this.name,
        this.number,
        this.originalText,
        this.originalType,
        this.power,
        this.purchaseUrls,
        this.rarity,
        this.setCode,
        this.subtypes,
        this.supertypes,
        this.text,
        this.toughness,
        this.type,
        this.types,
        this.uuid,
        this.count = 0,
      });

  MagicCard.fromJson(Map<String, dynamic> json) {
    colorIdentity = json['colorIdentity'].cast<String>();
    convertedManaCost = json['convertedManaCost'];
    id = json['id'] == null ? json['identifiers']['multiverseId'] : json['id'];
    manaCost = json['manaCost'];
    name = json['name'];
    number = json['number'];
    originalText = json['originalText'];
    originalType = json['originalType'];
    power = json['power'];
    purchaseUrls = json['purchaseUrls'] != null
        ? new PurchaseUrls.fromJson(json['purchaseUrls'])
        : null;
    rarity = json['rarity'];
    setCode = json['setCode'];
    subtypes = json['subtypes'].cast<String>();
    supertypes = json['supertypes'].cast<String>();
    text = json['text'];
    toughness = json['toughness'];
    type = json['type'];
    types = json['types'].cast<String>();
    uuid = json['uuid'];
    count = json['count'] == null ? 0 : json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colorIdentity'] = this.colorIdentity;
    data['convertedManaCost'] = this.convertedManaCost;
    data['id'] = this.id;

    data['manaCost'] = this.manaCost;
    data['name'] = this.name;
    data['number'] = this.number;
    data['originalText'] = this.originalText;
    data['originalType'] = this.originalType;
    data['power'] = this.power;
    if (this.purchaseUrls != null) {
      data['purchaseUrls'] = this.purchaseUrls.toJson();
    }
    data['rarity'] = this.rarity;
    data['setCode'] = this.setCode;
    data['subtypes'] = this.subtypes;
    data['supertypes'] = this.supertypes;
    data['text'] = this.text;
    data['toughness'] = this.toughness;
    data['type'] = this.type;
    data['types'] = this.types;
    data['uuid'] = this.uuid;
    data['count'] = this.count;
    return data;
  }
}

class PurchaseUrls {
  String cardKingdom;
  String cardKingdomFoil;
  String cardmarket;
  String tcgplayer;

  PurchaseUrls(
      {this.cardKingdom,
        this.cardKingdomFoil,
        this.cardmarket,
        this.tcgplayer});

  PurchaseUrls.fromJson(Map<String, dynamic> json) {
    cardKingdom = json['cardKingdom'];
    cardKingdomFoil = json['cardKingdomFoil'];
    cardmarket = json['cardmarket'];
    tcgplayer = json['tcgplayer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardKingdom'] = this.cardKingdom;
    data['cardKingdomFoil'] = this.cardKingdomFoil;
    data['cardmarket'] = this.cardmarket;
    data['tcgplayer'] = this.tcgplayer;
    return data;
  }
}