import 'package:flutter/material.dart';
import 'task.dart';
import 'TaskList.dart';

class TaskAdapter extends StatelessWidget  {
  final Task task;
  final TaskList taskList;

  const TaskAdapter(this.task, this.taskList);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.description),
          SizedBox(height: 4),
          Row(
            children: [
              Text(
                "Category: ${task.category}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Checkbox(
        value: task.isComplete,
        onChanged: (value) {
          if (value != null) {
            task.isComplete = value;
            taskList.notifyObservers();

          }
        },
      ),
    );
  }
}
