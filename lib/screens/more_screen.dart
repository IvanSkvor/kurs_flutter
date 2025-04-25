import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

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
            // Кнопка "Напоминание о задаче"
            _buildActionButton(
              text: "Напоминание о задаче",
              icon: Icons.notifications,
              color: Colors.purple,
              onPressed: () => _handleReminder(context),
            ),
            const SizedBox(height: 20),
            
            // Кнопка "Сделать регулярной"
            _buildActionButton(
              text: "Сделать регулярной", 
              icon: Icons.repeat,
              color: Colors.blue,
              onPressed: () => _makeRecurring(context),
            ),
            const SizedBox(height: 20),
            
            // Кнопка "Изменить"
            _buildActionButton(
              text: "Изменить",
              icon: Icons.edit,
              color: Colors.green,
              onPressed: () => _editTask(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
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
            borderRadius: BorderRadius.circular(12),
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
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleReminder(BuildContext context) {
    // Логика напоминания
    print('Создание напоминания');
  }

  void _makeRecurring(BuildContext context) {
    // Логика регулярной задачи
    print('Задача стала регулярной');
  }

  void _editTask(BuildContext context) {
    // Логика изменения
    print('Редактирование задачи');
  }
}