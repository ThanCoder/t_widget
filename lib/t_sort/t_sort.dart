class TSort {
  int id;
  String title;
  String ascTitle;
  String descTitle;
  TSort({
    required this.id,
    required this.title,
    required this.ascTitle,
    required this.descTitle,
  });

  //static
  static List<TSort> get getDefaultList {
    return [
      TSort(id: 100, title: 'Title', ascTitle: 'A-Z', descTitle: 'Z-A'),
      TSort(id: 101, title: 'Date', ascTitle: 'Oldest', descTitle: 'Newest'),
    ];
  }

  @override
  String toString() {
    return 'id: $id';
  }
}
