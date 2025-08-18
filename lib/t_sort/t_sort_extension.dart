import 't_sort.dart';

extension TSortExtension on List<TSort> {
  void sortId() {
    sort((a, b) {
      if (a.id > b.id) return 1;
      if (a.id < b.id) return -1;
      return 0;
    });
  }

  void sortTitle() {
    sort((a, b) => a.title.compareTo(b.title));
  }
}
