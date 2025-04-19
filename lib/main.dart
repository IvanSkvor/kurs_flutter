import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/task_service.dart';
import 'screens/tasks/tasks_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(  // ← Используем ChangeNotifierProvider
      create: (context) => TaskService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskMaster',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TasksScreen(),
    );
  }
}