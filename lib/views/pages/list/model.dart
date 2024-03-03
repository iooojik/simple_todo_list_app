import 'package:sqflite/sqflite.dart';
import 'package:next_step_app/db/client.dart';
import 'package:next_step_app/entity/folder_item.dart';
import 'package:next_step_app/entity/todo_item.dart';

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
    Model m = Model(
      folderItem,
      items: items ?? this.items,
    );
    m.items.sort((a, b) {
      if (a.done) {
        return 1;
      }
      return -1;
    });
    return m;
  }

  Future<void> delTodoItem(ToDoItem item) async {
    final db = await DbClient.db;

    await db.delete(
      'todo_items',
      where: 'id = ?',
      whereArgs: [item.id],
    );

    return;
  }

  Future<void> updTodoItem(ToDoItem item) async {
    final db = await DbClient.db;
    item.folderId = folder.id;

    await db.update(
      'todo_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'id = ?',
      whereArgs: [item.id],
    );

    return;
  }

  Future<void> addTodoItem(ToDoItem item) async {
    final db = await DbClient.db;
    item.folderId = folder.id;

    item.id = await db.insert(
      'todo_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return;
  }

  Future<List<ToDoItem>> getTodos(int folderId) async {
    final db = await DbClient.db;

    final List<Map<String, Object?>> folderMaps = await db.query(
      'todo_items',
      where: 'folderId = ?',
      whereArgs: [folderId],
    );

    List<ToDoItem> items = [
      for (final {
            'id': id as int,
            'text': text as String,
            'done': done as int,
          } in folderMaps)
        ToDoItem(text: text, done: done == 1, id: id),
    ];

    if (items.isEmpty) {
      return [];
    }

    return items;
  }

  Future<void> saveFolder(FolderItem item) async {
    final db = await DbClient.db;
    item.id = folder.id;

    await db.insert(
      'folders',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return;
  }

  Future<FolderItem> getFolder(int folderId) async {
    final db = await DbClient.db;
    final List<Map<String, Object?>> folderMaps;

    if (folderId <= 0) {
      folderMaps = await db.query('folders', limit: 1);
    } else {
      folderMaps = await db.query(
        'folders',
        where: 'id = ?',
        whereArgs: [folderId],
      );
    }

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
