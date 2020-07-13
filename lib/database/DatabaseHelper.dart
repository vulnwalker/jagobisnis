import 'dart:async';
import 'dart:io' as io;

import 'package:jagobisnis/database/model/account.dart';
import 'package:jagobisnis/database/model/cart.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE tabel_account (id INTEGER PRIMARY KEY, email text, password text,profit INTEGER,nama text,nomor_telepon text,jumlah_barang INTEGER,nama_bank text,nomor_rekening text,nama_rekening text,lisensi text,status INTEGER,kota text)");
    await db.execute(
        "CREATE TABLE cart (id INTEGER PRIMARY KEY, id_produk text, harga INTEGER, jumlah INTEGER, sub_total INTEGER )");
    // await db.execute(
    //     "CREATE TABLE info_account (id INTEGER PRIMARY KEY, jumlah_trade_point INTEGER, jumlah_absen int,jam )");
    //     print("database created");
  }

  Future<int> saveAccount(Account account) async {
    var dbClient = await db;
    int res = await dbClient.insert("tabel_account", account.toMap());
    return res;
  }
  Future<int> saveCart(Cart cart) async {
    var dbClient = await db;
    int res = await dbClient.insert("cart", cart.toMap());
    return res;
  }
  Future<int> sqlInsert(tableName,list) async {
    var dbClient = await db;
    int res = await dbClient.insert(tableName, list.toMap());
    return res;
  }

  Future<List<Account>> getAccount() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
    List<Account> employees = new List();
    for (int i = 0; i < list.length; i++) {
      // var account =
      //     new Account(list[i]["email"], list[i]["password"], list[i]["nama"], list[i]["nomor_telepon"], list[i]["saldo"], list[i]["status"] );
      // account.setAccountId(list[i]["id"]);
      // employees.add(account);
    }
    print(employees.length);
    return employees;
  }
  Future<int> accountRowCount() async{
    int returnValue = 0;
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
    returnValue = list.length;
    return returnValue;
  }

  Future<int> deleteAccount() async {
    var dbClient = await db;
    int res =await dbClient.rawDelete('DELETE FROM tabel_account ');
    return res;
  }

  Future<bool> updateAccount(Account account) async {
    var dbClient = await db;
    int res =   await dbClient.update("tabel_account", account.toMap());
    return res > 0 ? true : false;
  }

  void execute(String s) {}

}
