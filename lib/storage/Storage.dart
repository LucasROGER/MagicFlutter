import 'package:MagicFlutter/class/MagicCard.dart';
import 'package:localstorage/localstorage.dart';

typedef storageCallback = void Function(MagicCard item);

abstract class Storage<T> {
  LocalStorage storage;

  Storage(String storageName) {
    this.storage = new LocalStorage(storageName);
  }
  Future<List<T>> get();
  void set(List<T> value);
}
