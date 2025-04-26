import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Map<String, dynamic>> _pendingTasks = [];
  final List<Map<String, dynamic>> _completedTasks = [];
  final List<Map<String, dynamic>> _overdueTasks = [];
  final _taskNameController = TextEditingController();
  DateTime? _selectedDate;
  bool _showError = false;

  final List<String> _categories = [
    'Работа',
    'Учеба',
    'Дом',
    'Здоровье',
    'Финансы',
    'Покупки',
    'Путешествия',
    'Семья',
    'Хобби',
    'Личное'
  ];

  @override
  void initState() {
    super.initState();
    _removeOldCompletedTasks();
    _checkOverdueTasks();
    _setupPeriodicCheck();
  }

  void _setupPeriodicCheck() {
    Future.delayed(const Duration(minutes: 1), () {
      if (mounted) {
        _checkOverdueTasks();
        _setupPeriodicCheck();
      }
    });
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  void _removeOldCompletedTasks() {
    final now = DateTime.now();
    setState(() {
      _completedTasks.removeWhere((task) {
        final daysPassed = now.difference(task['date'] as DateTime).inDays;
        return daysPassed > 30;
      });
    });
  }

  void _checkOverdueTasks() {
    final now = DateTime.now();
    setState(() {
      _pendingTasks.removeWhere((task) {
        if ((task['date'] as DateTime).isBefore(now)) {
          _overdueTasks.add(task);
          return true;
        }
        return false;
      });
    });
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
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(double.infinity, 60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildMainButton(
              text: "Добавить задачу",
              icon: Icons.add,
              color: Colors.blue,
              onPressed: () => _showAddTaskDialog(context),
            ),
            const SizedBox(height: 20),
            _buildMainButton(
              text: "Категории", 
              icon: Icons.category,
              color: Colors.purple,
              onPressed: () => _showCategoriesDialog(context),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: _buildSmallButton(
                    text: "Завершенные",
                    icon: Icons.check_circle,
                    color: Colors.grey[300]!,
                    onPressed: () => _showTasksDialog(context, 'completed'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSmallButton(
                    text: "Незавершенные",
                    icon: Icons.pending_actions,
                    color: Colors.orange[200]!,
                    onPressed: () => _showTasksDialog(context, 'pending'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildSmallButton(
                    text: "Просроченные",
                    icon: Icons.warning,
                    color: Colors.red[200]!,
                    onPressed: () => _showTasksDialog(context, 'overdue'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoriesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Выберите категорию"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_categories[index]),
                  onTap: () {
                    Navigator.pop(context);
                    _showAddTaskDialog(context, category: _categories[index]);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showAddTaskDialog(BuildContext context, {String? category}) {
    setState(() {
      _showError = false;
      if (category != null) {
        _taskNameController.text = '$category: ';
      }
    });

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(category != null ? "Добавить задачу ($category)" : "Добавить новую задачу"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_showError)
                    const Text(
                      "Заполните все поля!",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  const SizedBox(height: 8),
                  const Text("Укажите название задачи"),
                  TextField(
                    controller: _taskNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Укажите дату завершения задачи"),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => _selectDate(context).then((_) {
                      setState(() {});
                    }),
                    child: Text(
                      _selectedDate == null
                          ? "Выбрать дату"
                          : DateFormat('dd.MM.yyyy').format(_selectedDate!),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Отмена"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_taskNameController.text.isEmpty || _selectedDate == null) {
                      setState(() => _showError = true);
                    } else {
                      _addTask(category: category);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Сохранить"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showTasksDialog(BuildContext context, String type) {
    final tasks = type == 'completed' 
        ? _completedTasks 
        : type == 'pending' 
            ? _pendingTasks 
            : _overdueTasks;
    final title = type == 'completed' 
        ? 'Завершенные задачи' 
        : type == 'pending' 
            ? 'Незавершенные задачи' 
            : 'Просроченные задачи';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(title),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Dismissible(
                      key: Key('${task['name']}_${task['date']}'),
                      background: Container(color: Colors.red[100]),
                      onDismissed: (direction) {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(task['name']),
                          subtitle: Text(
                            DateFormat('dd.MM.yyyy').format(task['date'] as DateTime),
                          ),
                          trailing: type == 'pending'
                              ? IconButton(
                                  icon: const Icon(Icons.check, color: Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      _completeTask(index);
                                      Navigator.pop(context);
                                      _showTasksDialog(context, 'pending');
                                    });
                                  },
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Закрыть"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _addTask({String? category}) {
    final newTask = {
      'name': _taskNameController.text,
      'date': _selectedDate!,
      'category': category,
    };

    setState(() {
      _pendingTasks.add(newTask); // Всегда добавляем в "Незавершенные"
      _taskNameController.clear();
      _selectedDate = null;
    });
  }

  void _completeTask(int index) {
    setState(() {
      _completedTasks.add(_pendingTasks[index]);
      _pendingTasks.removeAt(index);
    });
  }
}