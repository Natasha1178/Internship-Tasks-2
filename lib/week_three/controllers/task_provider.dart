import 'package:flutter/material.dart';
import 'package:internshiptask2/week_three/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void addTask(String title) {
    _tasks.insert(0, TaskModel(title));
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    notifyListeners();
  }
}
