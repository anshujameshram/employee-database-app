import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //private constructor
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'emp.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'create table employees(id integer primary key autoincrement,name text,post text,salary integer)');
  }
}
