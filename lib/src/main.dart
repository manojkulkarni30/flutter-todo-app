import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/todo_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Todo App',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.brown),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
