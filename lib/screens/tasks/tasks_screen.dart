import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBigRoundButton(
              context,
              text: "Добавить задачу",
              icon: Icons.add,
              color: Colors.blue,
              // ignore: avoid_print
              onPressed: () => print("Добавить задачу"),
            ),
            const SizedBox(height: 30),
            _buildBigRoundButton(
              context,
              text: "Задачи на 7 дней",
              icon: Icons.calendar_today,
              color: Colors.green,
              // ignore: avoid_print
              onPressed: () => print("Задачи на неделю"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBigRoundButton(
    BuildContext context, {
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
          ),
          padding: WidgetStateProperty.all(const EdgeInsets.all(20)), // Теперь правильно
          elevation: WidgetStateProperty.all(5),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}