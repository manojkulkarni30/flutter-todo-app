import 'package:flutter/material.dart';

import '../../services/todo_service.dart';
import '../../services/todo_service_api_impl.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  Future<void> _handleButtonPressed() async {
    try {
      TodoService todoService = TodoServiceApiImpl();

      // Fetch Todos
      // List<Todo> todos = await todoService.getTodos();
      // print('Todos: $todos');

      //Edit a Todo
      // Todo todo = todos[0].copyWith(
      //   title: 'Updated Title',
      //   description: 'Updated description from Flutter app',
      //   isCompleted: false,
      //   priority: TodoPriority.high,
      // );

      // final updatedTodo = await todoService.editTodo(todo);
      // print('Updated todo: $updatedTodo');

      // Add a new Todo
      // final dueDate = DateTime(2026, 7, 28);
      // final newTodo = Todo.create(
      //   title: 'New Todo from Flutter app',
      //   description: 'This is a new todo item.',
      //   category: TodoCategory.work,
      //   priority: TodoPriority.high,
      //   dueDate: dueDate,
      //   reminderDate: dueDate.subtract(const Duration(days: 2)),
      // );
      // todo = await todoService.addNewTodo(newTodo);
      // print('Added todo: $todo');

      //Delete a Todo
      await todoService.deleteTodo('f99b3228-d08c-4b58-b566-c2ff7889b78c');
      print('Todo is deleted successfully');
    } catch (e) {
      print('Error occured: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos', style: TextStyle(fontWeight: .bold)),
      ),
      body: Center(
        child: FilledButton(
          onPressed: _handleButtonPressed,
          child: const Text('Delete Todo'),
        ),
      ),
    );
  }
}
