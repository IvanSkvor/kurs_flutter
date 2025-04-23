import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TaskMaster',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Большая синяя кнопка
            _buildMainButton(
              context,
              text: "Добавить задачу",
              icon: Icons.add,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            
            // Большая зеленая кнопка
            _buildMainButton(
              context,
              text: "Задачи на 7 дней",
              icon: Icons.calendar_month,
              color: Colors.green,
            ),
            const SizedBox(height: 30),
            
            // Две маленькие кнопки в ряд
            Row(
              children: [
                Expanded(
                  child: _buildSecondaryButton(
                    "Выполненные",
                    Icons.check_circle,
                    Colors.grey[300]!,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSecondaryButton(
                    "Незавершенные",
                    Icons.pending_actions,
                    Colors.orange[200]!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton(
    BuildContext context, {
    required String text,
    required IconData icon,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
        ),
        onPressed: () {},
        icon: Icon(icon, size: 24),
        label: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(
    String text,
    IconData icon,
    Color color,
  ) {
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        icon: Icon(icon, size: 20),
        label: Text(text),
      ),
    );
  }
}