import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:untitled6/models/stock.dart';

class DatabaseHelper {
  //insert , create , update , delete , select
  static Database? _db;
  static Future<void> initializeDatabase() async {
    if (Platform.isWindows) {
      sqfliteFfiInit();
      var databaseFactory = databaseFactoryFfi;
      _db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      await _db!.execute(
        '''CREATE TABLE Stock (code INTEGER PRIMARY KEY, 
                name TEXT, type TEXT, quantity INTEGER, unit TEXT,
                 QR TEXT)''',
      );
    } else {
      _db = await openDatabase(
        'stock_db.db',
        version: 1,
        onCreate: (db, version) async {
          try {
            await db.execute('''CREATE TABLE Stock (code INTEGER PRIMARY KEY, 
                name TEXT, type TEXT, quantity INTEGER, unit TEXT,
                 QR TEXT)''');
            await db.execute('''CREATE TABLE Dismissed (
             id INTEGER PRIMARY KEY,
              quantity INTEGER,
              codeId INTEGER ,       
              FOREIGN KEY (codeId) REFERENCES Stock (code)
          )''');
            await db.execute('''CREATE TABLE Incoming (
    id INTEGER PRIMARY KEY,
    quantity INTEGER,        
    codeId INTEGER ,       
    FOREIGN KEY (codeId) REFERENCES Stock (code)
 
    )''');
            print("Database created!!!");
          } catch (error) {
            print("There's an error while creation");
            print(error.toString());
          }
        },
        onOpen: (db) async {
          print("Database opened !!!");
        },
        onConfigure: (db) {
          db.execute('PRAGMA foreign_keys = ON');
        },
      );
    }
  }

  //CRUD Operations

  //insert

  static Future<void> insertNewQuery(Stock stock) async {
    if (_db != null) {
      try {
        await _db!.rawInsert(
            "INSERT INTO Stock (code,name,type,quantity,unit,QR) VALUES(?,?,?,?,?,?)",
            [
              stock.code,
              stock.name,
              stock.type,
              stock.quantity,
              stock.unit,
              stock.qr
            ]);
        print("Inserted Successfully");
      } catch (error) {
        print("Error while insert data");
        print(error.toString());
      }
    } else {
      print("Database not initialized yet");
    }
  }

  //get data
  static Future<List<Map<String, dynamic>>> getAllQueries() async {
    List<Map<String, dynamic>> list =
        await _db!.rawQuery('SELECT * FROM Stock');
    return list;
  }

  static Future<List<Map<String, dynamic>>> getAllQueriesDependOnName({required String searchQuery}) async {
    print(searchQuery);
    List<Map<String, dynamic>> list =
    searchQuery == "" ? await _db!.rawQuery('SELECT * FROM Stock') : await _db!.rawQuery('''
    SELECT * 
    FROM Stock
    WHERE name LIKE '%$searchQuery%'
  ''');
    return list;
  }
  //get one query
  static Future<void> getOneQuery({required int codeId}) async {
    List<Map<String, dynamic>> list =
        await _db!.rawQuery('SELECT * FROM Stock WHERE code = ?', [codeId]);
    print(list);
  }

  // update - edit
  static Future<void> updateData({required Stock stock}) async {
    int count = await _db!.rawUpdate('''
       UPDATE Stock SET name = ?, type = ?,
       quantity = ?, unit = ?, QR =? 
       WHERE code = ?''', [
      stock.name,
      stock.type,
      stock.quantity,
      stock.unit,
      stock.qr,
      stock.code,
    ]);
    if (count == 1) {
      print("Updated Successfully");
    } else {
      print("Error in updating");
    }
  }

  //delete
  static Future<void> deleteQuery({required int code}) async {
    int count =
        await _db!.rawDelete('DELETE FROM Stock WHERE code = ?', [code]);
    if (count == 1) {
      print("Deleted Successfully");
    } else {
      print("Error");
    }
  }
}
