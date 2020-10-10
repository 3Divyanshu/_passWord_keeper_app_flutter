import 'package:pass_word/data/database.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DataBaseConnection _dataBaseConnection;

  Repository() {
    _dataBaseConnection = DataBaseConnection();
  }

  static Database _database;
  static final table = 'My_table';

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _dataBaseConnection.setDatabase();
    return database;
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection.query(
      table,
    );
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection.update(table, data,
        where: 'id=?', whereArgs: [data['id']]);
  }

  deleteData(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }

  readDataByColumnName(table, columnName, columnValue) async {
    var connection = await database;
    return await connection
        .query(table, where: '$columnName', whereArgs: [columnValue]);
  }
}
