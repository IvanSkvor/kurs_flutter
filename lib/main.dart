import 'package:flutter/material.dart';
import 'package:taskmaster/screens/tasks/tasks_screen.dart';
import 'package:taskmaster/screens/calendar_screen.dart';
import 'package:taskmaster/screens/more_screen.dart';
import 'package:taskmaster/screens/settings_screen.dart'; // Исключаем конфликт

void main() => runApp(const TaskMasterApp());

class TaskMasterApp extends StatelessWidget {
  const TaskMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TasksScreen(), // Теперь без конфликтов
    const CalendarScreen(),
    const MoreScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Задачи'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Календарь'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Ещё'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
        ],
      ),
    );
  }
}