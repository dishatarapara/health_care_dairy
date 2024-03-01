import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/notification_model.dart';

class Dbhelper {
  static Database? _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int version = 1;

  static const String N_UserId = 'user_id';
  static const String N_UserName = 'user_name';

  Future<Database> get db async {
    if(_db != null) {
      return _db!;
    }

    _db = await initDb();

    return _db!;
  }

  Future<Database> initDb() async {
    io.Directory documentDirectory = await getApplicationSupportDirectory();
    String path = join(documentDirectory.path, DB_Name);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $N_UserId TEXT, "
        " $N_UserName TEXT, "
        " PRIMARY KEY ($N_UserId)"
        ")");
  }

  Future<UserModel> saveData(UserModel user) async{
    var dbClient = await db;
    user.user_id = (await dbClient.insert(Table_User, user.toMap())) as int;
    return user;
  }
}