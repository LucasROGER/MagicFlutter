import 'dart:convert';
import 'dart:typed_data';

import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:MagicFlutter/class/MagicDeck.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:io' as Io;

class ProfileStorage {
  final LocalStorage storage = new LocalStorage('my_profile');


  Future<Uint8List> get() async {

    dynamic profilePicture = await storage.getItem('profile_picture');
    if (profilePicture == null)
      return null;
    else
      return base64Decode(profilePicture);
  }

  void set(Image image) async {
    await storage.setItem('profile_picture', base64Encode(Io.File(image.toString()).readAsBytesSync()));
  }

  void setB64(String base64) async {
    await storage.setItem('profile_picture', base64);
  }


  void clear() {
    storage.clear();
  }
}
