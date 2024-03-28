import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../model/notification_model.dart';

class DbHelper {
  // static final DateFormat formatter = DateFormat('h:mm a');

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      description TEXT,
      time TEXT
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'notification.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        debugPrint("...creating a table...");
        await createTables(database);
      },
    );
  }

  // static String formatTime(DateTime dateTime) {
  //   return formatter.format(dateTime);
  // }

  static Future<int> createItem(String title, String description, String time) async {
    final db = await DbHelper.db();

    final data = {'title': title, 'description': description, 'time': time};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DbHelper.db();
    return db.query('items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DbHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String title, String description, String time) async {
    final db = await DbHelper.db();

    final data = {
      'title': title,
      'description': description,
      'time': DateTime.now().toString()
    };

    final result = await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DbHelper.db();
    try {
      await db.delete('items', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went wrong when deleting an item: $e");
    }
  }
}