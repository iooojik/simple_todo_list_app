class ToDoItem {
  int id = -1;
  int seqUpdate = 0;
  int folderId = 0;

  String text;
  final bool done;

  ToDoItem({
    required this.text,
    this.done = false,
    this.id = -1,
  });

  ToDoItem copyWith({
    String? text,
    bool? done,
  }) {
    return ToDoItem(
      text: text ?? this.text,
      done: done ?? this.done,
    );
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> result = {
      'text': text,
      'done': done ? 1 : 0,
      'seqUpdate': DateTime.now().microsecondsSinceEpoch,
      'folderId': folderId,
    };
    if (id > 0) {
      result['id'] = id;
    }
    return result;
  }
}
