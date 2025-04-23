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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Большая кнопка "Добавить задачу"
            _buildMainButton(
              text: "Добавить задачу",
              icon: Icons.add,
              color: Colors.blue,
              onPressed: () => _handleAddTask(context),
            ),
            const SizedBox(height: 20),
            
            // Большая кнопка "Задачи на 7 дней"
            _buildMainButton(
              text: "Задачи на 7 дней",
              icon: Icons.calendar_month,
              color: Colors.green,
              onPressed: () => _handleWeeklyTasks(context),
            ),
            const SizedBox(height: 30),
            
            // Две маленькие кнопки в ряд
            Row(
              children: [
                Expanded(
                  child: _buildSmallButton(
                    text: "Выполненные",
                    icon: Icons.check_circle,
                    color: Colors.grey[300]!,
                    onPressed: () => _showCompletedTasks(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSmallButton(
                    text: "Незавершенные",
                    icon: Icons.pending_actions,
                    color: Colors.orange[200]!,
                    onPressed: () => _showPendingTasks(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          padding: const EdgeInsets.all(20),
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

  Widget _buildSmallButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(text),
      ),
    );
  }

  void _handleAddTask(BuildContext context) {
    print('Добавление задачи');
  }

  void _handleWeeklyTasks(BuildContext context) {
    print('Просмотр задач на неделю');
  }

  void _showCompletedTasks(BuildContext context) {
    print('Показать выполненные задачи');
  }

  void _showPendingTasks(BuildContext context) {
    print('Показать незавершенные задачи');
  }
}