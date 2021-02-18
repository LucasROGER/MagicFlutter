extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension ListExtension<T> on List<T> {
  operator *(int nb) {
    List<T> res = [];

    for (int i = 0; i < nb; i++) {
      res += this;
    }

    return res;
  }
}