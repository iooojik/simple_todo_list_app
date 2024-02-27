import 'package:todo_list_app/entity/folder_item.dart';
import 'package:todo_list_app/entity/todo_item.dart';

import '../../../db/client.dart';

class Model {
  final List<ToDoItem> items;
  final FolderItem folder;

  Model(
    this.folder, {
    this.items = const <ToDoItem>[],
  });

  Model copyWith({
    List<ToDoItem>? items,
    required FolderItem folderItem,
  }) {
    return Model(
      folderItem,
      items: items ?? this.items,
    );
  }

  Future<FolderItem> getFolder(int folderId) async {
    final db = await DbClient.db;

    final List<Map<String, Object?>> folderMaps = await db.query(
      'folders',
      where: 'id = ?',
      whereArgs: [folderId],
    );

    List<FolderItem> folders = [
      for (final {
            'id': id as int,
            'name': name as String,
          } in folderMaps)
        FolderItem(id, name),
    ];

    if (folders.isEmpty) {
      return FolderItem(-1, "");
    }

    return folders[0];
  }
}
