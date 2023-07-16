// ignore_for_file: file_names

import '../TaskListWidget.dart';
import 'task.dart';

abstract class Observer {
  void update(List<Task> taskList);
}

class TaskListObserver extends Observer {
  late TaskListWidgetState _taskListWidgetState;

  TaskListObserver(TaskListWidgetState taskListWidgetState) {
    _taskListWidgetState = taskListWidgetState;
  }

  @override
  void update(List<Task> taskList) {
    _taskListWidgetState.update(taskList);
  }
}
