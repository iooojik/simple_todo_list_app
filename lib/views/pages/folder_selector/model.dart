import 'package:todo_list_app/entity/folder_item.dart';

class Model {
  final List<FolderItem> items;

  Model({
    this.items = const <FolderItem>[],
  });

  Model copyWith({
    List<FolderItem>? items,
  }) {
    return Model(
      items: items ?? this.items,
    );
  }

  Future<List<FolderItem>> getFolders() async {
    // todo get from local storage
    List<FolderItem> folders = [];
    return folders;
  }

  addFolder(FolderItem item) async {
    //   todo add to db
  }
}
