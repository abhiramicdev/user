import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_app/models/user_details.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider DB = DBProvider._();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String userDetailsTable = "CREATE TABLE IF NOT EXISTS UserDetails ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "username TEXT,"
        "email TEXT,"
        "profileImage TEXT,"
        "phone TEXT,"
        "website TEXT,"
        "street TEXT,"
        "suite TEXT,"
        "city TEXT,"
        "zipcode TEXT,"
        "companyName TEXT,"
        "catchPhrase TEXT,"
        "bs TEXT"
        ")";

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "UserApp.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute(userDetailsTable);
    }, onCreate: (Database db, int version) async {
      await db.execute(userDetailsTable);
    });
  }

  addUserInfo(UserDetails userDetails) async {
    final db = await database;
    var table = await db?.rawQuery("SELECT MAX(id)+1 as id FROM UserDetails");
    Object? id = table?.first['id'];
    var raw = await db?.rawInsert(
        "INSERT Into UserDetails (id,name,username,email,profileImage,phone,website,street,suite,city,zipcode,companyName,catchPhrase,bs)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          userDetails.name,
          userDetails.username,
          userDetails.email,
          userDetails.profileImage,
          userDetails.phone,
          userDetails.website,
          userDetails.street,
          userDetails.suite,
          userDetails.city,
          userDetails.zipcode,
          userDetails.companyName,
          userDetails.catchPhrase,
          userDetails.bs,
        ]);

    return raw;
  }

  Future<List<UserDetails>> getUserDetails() async {
    final db = await database;
    var res = await db!.query("UserDetails");
    List<UserDetails> list =
        res.isNotEmpty ? res.map((c) => UserDetails.fromMap(c)).toList() : [];
    return list;
  }
}
