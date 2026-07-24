import 'dart:collection';

import 'package:flutter/material.dart';

import '../core/errors/exceptions.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';
import '../services/todo_service_api_impl.dart';

enum TodoLoadState {
  initial,
  loading,
  success,
  failed,
}

class TodoProvider extends ChangeNotifier {
  TodoProvider({TodoService? todoService})
    : _todoService = todoService ?? TodoServiceApiImpl();

  final TodoService _todoService;

  // States for todo page
  List<Todo> _todos = [];
  String? _errorMessage;
  TodoLoadState _loadState = TodoLoadState.initial;

  // Getters

  // For todo page
  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);
  String? get errorMessage => _errorMessage;
  TodoLoadState get loadState => _loadState;

  Future<void> getTodos() async {
    _errorMessage = null;
    _loadState = TodoLoadState.loading;
    notifyListeners();

    try {
      _todos = await _todoService.getTodos();
      _loadState = TodoLoadState.success;
    } on AppException catch (e) {
      _loadState = TodoLoadState.failed;
      _errorMessage = e.message;
    } finally {
      notifyListeners();
    }
  }
}
