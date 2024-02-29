class FolderItem {
  int id = 0;
  String name = "";
  int seqUpdate = 0;

  FolderItem(
    this.id,
    this.name,
  );

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'seqUpdate': DateTime.now().microsecondsSinceEpoch,
    };
  }
}
