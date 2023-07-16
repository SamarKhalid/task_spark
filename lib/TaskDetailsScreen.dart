// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'classes/task.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  const TaskDetailsScreen({required this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  String category = '';
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    category = widget.task.category;  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              final newTask = Task(
                title: _titleController.text,
                description: _descriptionController.text,
                category: category,
              );
              Navigator.pop(context, newTask);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title:',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Enter task title',
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter task description',
              ),
              maxLines: null,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Category:',
              style: Theme.of(context).textTheme.subtitle1,
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
      ),
    );
  }
}
