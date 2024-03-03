import 'package:flutter/material.dart';
import 'package:next_step_app/db/queries.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbClient {
  static Future<Database> db = initDb();

  static Future<Database> initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      onCreate: (db, version) {
        db.execute(
          createFoldersTable,
        );
        db.execute(
          createTodoItemsTable,
        );
      },
      onUpgrade: (db, version, oldVersion) {
        db.execute(
          createFoldersTable,
        );
        db.execute(
          createTodoItemsTable,
        );
      },
      // upgrades and downgrades.
      version: 3,
    );
  }
}
