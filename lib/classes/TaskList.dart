// ignore_for_file: file_names

import 'dart:async';
import 'Observer.dart';
import 'task.dart';

class TaskList {
  List<Task>? _tasks;
  List<Observer>? _observers;
  Timer? _deleteTimer;
  bool showTimer = false;

  TaskList() {
    _tasks = [];
    _observers = <Observer>[];
  }

  set tasks(List<Task>? value) {
    if (_tasks == value) return; // check if the value is the same
    _tasks = value;
    notifyObservers();
  }

  void addObserver(Observer observer) {
    _observers?.add(observer);
  }

  void removeObserver(Observer observer) {
    _observers?.remove(observer);
  }

  void notifyObservers() {
    if (_observers != null && _tasks != null) {
      for (Observer observer in _observers!) {
        observer.update(_tasks!);
      }
    }
  }

  void addTask(Task task) {
    _tasks?.add(task);
    notifyObservers();
  }

  void editTask(int index, Task task) {
    _tasks![index] = task;
    notifyObservers();
  }

  void deleteTask(int index ) {
    _tasks?.removeAt(index);
    notifyObservers();
  }


  List<Task>? get tasks => _tasks;
}
