import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import '../../models/task_model.dart';
import '../../services/task_service.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Добавить задачу')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Поле названия задачи
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Название задачи',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название задачи';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Выбор даты
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Дата выполнения',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 10),
                      Text(
                        _selectedDate == null
                            ? 'Выберите дату'
                            : DateFormat('dd.MM.yyyy').format(_selectedDate!),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Кнопка сохранения
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _selectedDate != null) {
                      taskService.addTask(
                        Task(
                          title: _titleController.text,
                          date: DateFormat('dd.MM.yyyy').format(_selectedDate!),
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Заполните все поля!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Сохранить',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateFormat {
  DateFormat(String s);
  
  format(DateTime dateTime) {}
}