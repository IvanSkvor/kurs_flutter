import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Календарь'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              // Возврат к текущей дате
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Переход к текущей дате')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Заголовок месяца и навигация
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {}, // Переход к предыдущему месяцу
                ),
                const Text(
                  'Апрель 2024',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {}, // Переход к следующему месяцу
                ),
              ],
            ),
          ),
          // Дни недели
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Пн', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Вт', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Ср', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Чт', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Пт', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Сб', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              Text('Вс', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
          // Сетка календаря
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.2,
              ),
              itemCount: 42, // 6 недель
              itemBuilder: (context, index) {
                final day = index - 5; // Примерная логика дней
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: day == DateTime.now().day 
                        // ignore: deprecated_member_use
                        ? Colors.blue.withOpacity(0.2)
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      day > 0 && day <= 30 ? day.toString() : '',
                      style: TextStyle(
                        color: (index % 7 >= 5) ? Colors.red : null,
                        fontWeight: day == DateTime.now().day 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Добавление события
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Добавить новое событие')),
          );
        },
      ),
    );
  }
}