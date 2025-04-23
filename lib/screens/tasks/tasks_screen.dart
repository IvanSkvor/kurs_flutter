import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мои задачи')),
      body: ListView(
        children: [
          TaskCard(
            title: 'Сделать домашку',
            onPressed: () => print('Задача выбрана!'),  // Теперь работает
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => print('Новая задача'),  // `onPressed` здесь корректно
            child: const Text('Добавить задачу'),
          ),
        ],
      ),
    );
  }
}

// Кастомный виджет с поддержкой `onPressed`
class TaskCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const TaskCard({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        onTap: onPressed,  // Передаем в `onTap` ListTile
      ),
    );
  }
}