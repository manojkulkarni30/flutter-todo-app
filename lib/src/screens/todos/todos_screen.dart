import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/todo_provider.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await context.read<TodoProvider>().getTodos();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos', style: TextStyle(fontWeight: .bold)),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          switch (todoProvider.loadState) {
            case TodoLoadState.initial:
            case TodoLoadState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case TodoLoadState.failed:
              return Center(
                child: Text(todoProvider.errorMessage!),
              );
            case TodoLoadState.success:
              final todos = todoProvider.todos;
              return RefreshIndicator(
                onRefresh: todoProvider.getTodos,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    todos.isEmpty
                        ? const SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Text(
                                'No todos yet.\nTap + to add your first one!',
                                textAlign: .center,
                              ),
                            ),
                          )
                        : SliverList.builder(
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              final todo = todos[index];
                              return ListTile(
                                title: Text(todo.title),
                                key: ValueKey(todo.id),
                                subtitle: Text(todo.description ?? ''),
                              );
                            },
                          ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
