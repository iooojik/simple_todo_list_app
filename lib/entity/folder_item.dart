class FolderItem {
  int id = 0;
  String name = "";
  int seqUpdate = 0;

  FolderItem(
    this.id,
    this.name,
  );

  Map<String, Object?> toMap() {
    Map<String, Object?> data = {
      'name': name,
      'seqUpdate': DateTime.now().microsecondsSinceEpoch,
    };
    if (id > 0) {
      data['id'] = id;
    }
    return data;
  }
}
