import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_management_app/model/task.dart';

class DB_Helper{
  static final DB_Helper _instance = DB_Helper._internal();
  factory DB_Helper() => _instance;

  DB_Helper._internal();

  static Database? _db;

  Future<Database> get database async{
    if(_db != null) {
      return _db!;
    }
    _db = await _initDB();

    return _db!;
  }

  Future<Database> _initDB() async{
    String path = join(await getDatabasesPath(),'tasks.db');
    return await openDatabase(path,version: 1, onCreate: (db,version){
      return db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, dueDate TEXT, isCompleted INTEGER)',);
    },);
  }

  Future<List<Task>> getAllTasks() async{
    final db = await database;
    final List<Map<String, dynamic>> tasks = await db.query('tasks');
    return List.generate(tasks.length, (index){
      return Task.fromMap(tasks[index]);
    });
  }

  Future<void> insertTask(Task task) async{
    final db = await database;
    await db.insert('tasks', task.toMap());
  }
  
  Future<void> updateTask(Task task) async{
    final db = await database;
    await db.update('tasks', task.toMap(),whereArgs:[task.id], where: 'id = ?' );
  }

  Future<void> deleteTask(int id) async{
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

}