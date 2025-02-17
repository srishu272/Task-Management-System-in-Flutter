import 'package:flutter/material.dart';
import 'package:task_management_app/helper/db_helper.dart';

import '../model/task.dart';

class TaskProvider with ChangeNotifier{
  List<Task> _tasks = [];
  final DB_Helper _db_helper = DB_Helper();

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async{
    _tasks = await _db_helper.getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async{
    await _db_helper.insertTask(task);
    await fetchTasks();
  }

  Future<void> updateTask(Task task) async{
    await _db_helper.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(int id)async{
    await _db_helper.deleteTask(id);
    await fetchTasks();
  }
}