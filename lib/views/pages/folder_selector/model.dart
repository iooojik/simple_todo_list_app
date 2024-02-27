import 'dart:developer';

import 'package:todo_list_app/db/client.dart';
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
    final db = await DbClient.db;

    final List<Map<String, Object?>> folderMaps = await db.query('folders');

    List<FolderItem> folders = [
      for (final {
            'id': id as int,
            'name': name as String,
          } in folderMaps)
        FolderItem(id, name),
    ];

    return folders;
  }

  addFolder(FolderItem item) async {
    //   todo add to db
  }
}
