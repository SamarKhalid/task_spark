// ignore_for_file: file_names

import 'task.dart';

class TaskFactory {
  static Task createPersonalTask({required String title, String description = '', required String category}) {
    return Task(title: title, description: description, isComplete: false, category: category);
  }

  static Task createWorkTask({required String title, String description = '', required String category}) {
    return Task(title: title, description: description, isComplete: false, category: category);
  }

  static Task createStudyingTask({required String title, String description = '', required String category}) {
    return Task(title: title, description: description, isComplete: false, category: category);
  }
}
