import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_passWord_sqflite");
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        'CREATE TABLE password(id INTEGER PRIMARY KEY, title TEXT, password TEXT,image TEXT)');
  }
}
