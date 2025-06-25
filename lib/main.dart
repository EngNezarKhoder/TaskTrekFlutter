import 'package:flutter/material.dart';
import 'package:task_app/widgets/home_page.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Task App",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
