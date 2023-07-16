import 'package:flutter/material.dart';
import 'package:task_spark/HomeScreen.dart';
import 'TaskDetailsScreen.dart';
import 'classes/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        title: 'Task Spark',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/task': (context) => TaskDetailsScreen(task: Task(title: '', description: '', isComplete: false, category: '')),},
      ),
    );
  }
}
