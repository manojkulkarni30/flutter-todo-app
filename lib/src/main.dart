import 'package:flutter/material.dart';

import 'screens/main_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.brown),
      ),
      home: const MainScreen(),
    );
  }
}
