import 'package:flutter/material.dart'; // Добавьте этот импорт
import '../models/task_model.dart';

class TaskService extends ChangeNotifier {  // ← Добавьте наследование
  List<Task> tasks = [];

  void addTask(Task newTask) {
    tasks.add(newTask);
    notifyListeners(); // ← Важно: уведомляем слушателей об изменениях
  }

  void toggleDone(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    notifyListeners(); // ← Уведомляем слушателей
  }
}