import 'package:next_step_app/db/client.dart';
import 'package:next_step_app/entity/folder_item.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<void> addFolder(FolderItem item) async {
    final db = await DbClient.db;

    item.id = await db.insert(
      'folders',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return;
  }

  Future<void> deleteFolder(int id) async {
    final db = await DbClient.db;

    await db.delete(
      'folders',
      where: 'id = ?',
      whereArgs: [id],
    );

    return;
  }
}
