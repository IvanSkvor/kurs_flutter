import 'package:flutter/material.dart';
import 'package:kurs_flutter/screens/tasks/add_task_screen.dart';
import 'package:provider/provider.dart';
import '../../services/task_service.dart';
import 'widgets/task_card.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Мои задачи')),
      body: ListView.builder(
        itemCount: taskService.tasks.length,
        itemBuilder: (context, index) => TaskCard(task: taskService.tasks[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddTaskScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}