import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/services.dart';

enum SoundType { Card, Deck, Click, Validate, AddCard, Camera }

class SoundController {
  AudioCache cache = new AudioCache();

  Future<void> playSound(SoundType type) async {
    if (type == SoundType.Click) return _playLocalSound("sounds/click.mp3");
    else if (type == SoundType.Card) return await _playLocalSound("sounds/card.mp3");
    else if (type == SoundType.Deck) return await _playLocalSound("sounds/deck.mp3");
    else if (type == SoundType.Validate) return await _playLocalSound("sounds/validate.mp3");
    else if (type == SoundType.AddCard) return await _playLocalSound("sounds/cardAdded.mp3");
    else if (type == SoundType.Camera) return await _playLocalSound("sounds/camera.mp3");
    else return;
  }

  Future<void> _playLocalSound(path) async {
    await cache.play(path, volume: 0.05);
  }

  void _playClickSound() async {
    SystemSound.play(SystemSoundType.click);
  }
}
