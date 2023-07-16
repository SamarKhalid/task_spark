// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:task_spark/TaskListWidget.dart';
import 'package:task_spark/classes/Observer.dart';
import 'package:task_spark/classes/TaskManager.dart';
import 'package:task_spark/classes/task.dart';
import 'classes/TaskFactory.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements Observer {
  final TaskManager _taskManager = TaskManager();

  @override
  void dispose() {
    _taskManager.taskList.removeObserver(this);
    super.dispose();
  }

  @override
  void update(List<Task> taskList) {
    setState(() {
      _taskManager.tasks = taskList;
    });
  }

  @override
  void initState() {
    super.initState();
    _taskManager.taskList.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TaskListWidget(taskList: _taskManager.taskList),
        ),
      ],
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String title = '';
              String description = '';
              String category = 'Personal';

              return AlertDialog(
                title: const Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                    DropdownButton<String>(
                      value: category,
                      items: <String>['Personal', 'Work', 'Studying'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          category = value!;
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Task newTask;
                      switch (category) {
                        case 'work':
                          newTask = TaskFactory.createWorkTask(title: title, description: description, category: category);
                          break;
                        case 'studying':
                          newTask = TaskFactory.createStudyingTask(title: title, description: description, category: category);
                          break;
                        default:
                          newTask = TaskFactory.createPersonalTask(title: title, description: description, category: category);
                          break;
                      }
                      _taskManager.addTask(title, description: description,newTask.category);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
