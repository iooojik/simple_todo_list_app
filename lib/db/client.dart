import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_app/db/queries.dart';

class DbClient {
  static Future<Database> db = initDb();

  static Future<Database> initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      onCreate: (db, version) {
        return db.execute(
          createFoldersTable,
        );
      },
      // upgrades and downgrades.
      version: 2,
    );
  }
}
