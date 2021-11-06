import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/task_model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database!;
  }

  initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'todo_app_db.db'),
        onCreate: (db, version) async {
      await db.execute(
          '''create table tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, createdDate TEXT)''');
    }, version: 1);
  }

  addNewTask(Task task) async {
    final db = await database;
    db.insert("tasks", task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  clear() async {
    final db = await database;
    db.delete('tasks');
  }

  Future<dynamic> getAllTasks() async {
    final db = await database;
    var res = await db.query('tasks');
    if (res.length == 0) {
      return Null;
    } else {
      return res.toList();
    }
  }
}
