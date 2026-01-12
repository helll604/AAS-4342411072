import 'package:flutter/material.dart';
import '../database/task_database.dart';
import '../models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> tasks = [];

  Future<void> loadTasks() async {
    tasks = await TaskDatabase.instance.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await TaskDatabase.instance.insertTask(task);
    print("DATA MASUK: ${task.title}");
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await TaskDatabase.instance.deleteTask(id);
    await loadTasks();
  }
}
