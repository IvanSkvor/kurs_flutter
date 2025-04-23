import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String screenTitle;
  
  const AppBarWidget({
    super.key,
    required this.screenTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'TaskMaster • $screenTitle',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.blue,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}