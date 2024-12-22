// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
//   static Database? _database; // Singleton Database
//
//   String tableName = 'form_data';
//   String colId = 'id';
//   String colSizeOptions = 'sizeOptions';
//   String colColourOptions = 'colourOptions';
//   String colAttributeDataList = 'attributeDataList';
//   String colSingleOption = 'singleOption';
//
//   DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper
//
//   factory DatabaseHelper() {
//     if (_databaseHelper == null) {
//       _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
//     }
//     return _databaseHelper!;
//   }
//
//   Future<Database> get database async {
//     if (_database == null) {
//       _database = await initializeDatabase();
//     }
//     return _database!;
//   }
//
//   Future<Database> initializeDatabase() async {
//     String path = join(await getDatabasesPath(), 'form_data.db');
//     var database = await openDatabase(path, version: 1, onCreate: _createDb);
//     return database;
//   }
//
//   void _createDb(Database db, int newVersion) async {
//     await db.execute('''
//       CREATE TABLE $tableName (
//         $colId INTEGER PRIMARY KEY AUTOINCREMENT,
//         $colSizeOptions TEXT,
//         $colColourOptions TEXT,
//         $colAttributeDataList TEXT,
//         $colSingleOption TEXT
//       )
//     ''');
//   }
//
//   Future<int> insertFormData(Map<String, dynamic> formData) async {
//     Database db = await database;
//     int result = await db.insert(tableName, formData);
//     return result;
//   }
//
//   Future<List<Map<String, dynamic>>> getFormDataList() async {
//     Database db = await database;
//     var result = await db.query(tableName);
//     return result;
//   }
// }





//   // Store data in SQLite
//       var dbHelper = DatabaseHelper();
//       await dbHelper.insertFormData({
//         dbHelper.colSizeOptions: sizeLabels.join(', '), // Convert list to comma-separated string
//         dbHelper.colColourOptions: colorLabels.join(', '),
//         dbHelper.colAttributeDataList: attributeDataList.toString(), // Convert list to string representation
//         dbHelper.colSingleOption: selectSingleOption.toString(),
//       });