import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TaskDetailsScreen.dart';
import 'classes/Observer.dart';
import 'classes/TaskAdapter.dart';
import 'classes/TaskList.dart';
import 'classes/task.dart';

class TaskListWidget extends StatefulWidget {
  final TaskList taskList;

  const TaskListWidget({Key? key, required this.taskList}) : super(key: key);

  @override
  TaskListWidgetState createState() => TaskListWidgetState();
}

class TaskListWidgetState extends State<TaskListWidget>
    implements Observer {
  late TaskList _taskList;

  @override
  void initState() {
    super.initState();
    _taskList = widget.taskList;
    _taskList.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _taskList.removeObserver(this);
  }

  @override
  void update(List<Task> taskList) {
    setState(() {
      _taskList.tasks = taskList;
    });
  }

  Future<void> _showEditTaskScreen(BuildContext context, Task task) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsScreen(task: task),
      ),
    );
    if (updatedTask != null && updatedTask is Task) {
      _taskList.editTask(_taskList.tasks!.indexOf(task), updatedTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _taskList.tasks?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Task task = _taskList.tasks![index];
        if (!task.isComplete) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                _showEditTaskScreen(context, task);
              } else if (direction == DismissDirection.endToStart) {
                _taskList.deleteTask(index);
              }
            },
            background: Container(
              color: Colors.green,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            child: TaskAdapter(task, _taskList),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
