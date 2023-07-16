// ignore_for_file: file_names

import 'TaskList.dart';
import 'task.dart';

class TaskManager  {
  final TaskList taskList;

  TaskManager() : taskList = TaskList();
  set tasks(List<Task>? value) {
    taskList.tasks = value;
  }

  void addTask(String title ,String category , {required String description} ) {
  final task = Task(title: title, description: description, category: category);
  taskList.addTask(task);
  }

  void editTask(int index, String title, String category, {required String description}) {
  final task = Task(title: title, description: description, category: category);
  taskList.editTask(index, task);
  }

  void deleteTask(int index) {
  taskList.deleteTask(index);
  }



  List<Task>? get tasks => taskList.tasks;
}
