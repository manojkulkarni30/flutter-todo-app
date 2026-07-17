import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../core/errors/exceptions.dart';
import '../models/todo.dart';
import 'todo_service.dart';

class TodoServiceApiImpl implements TodoService {
  final String baseUrl = Platform.isIOS
      ? 'http://localhost:5159/api'
      : 'http://10.0.2.2:5159/api';

  @override
  Future<List<Todo>> getTodos() async {
    return _execute(
      action: () async {
        final response = await http.get(Uri.parse('$baseUrl/todos'));

        return _handleResponse<List<Todo>>(
          response,
          (body) {
            final jsonData = body['data'] as List;
            return jsonData.map((e) => Todo.fromMap(e)).toList();
          },
        );
      },
      context: 'fetching todos',
    );
  }

  @override
  Future<Todo> addNewTodo(Todo todo) async {
    return _execute(
      action: () async {
        final response = await http.post(
          Uri.parse('$baseUrl/todos'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(todo.toMap()),
        );

        return _handleResponse<Todo>(
          response,
          (body) {
            final jsonData = body['data'];
            return Todo.fromMap(jsonData);
          },
        );
      },
      context: 'creating new todo',
    );
  }

  @override
  Future<Todo> editTodo(Todo todo) async {
    return _execute(
      action: () async {
        final response = await http.put(
          Uri.parse('$baseUrl/todos/${todo.id}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(todo.toMap()),
        );

        return _handleResponse<Todo>(
          response,
          (body) {
            final jsonData = body['data'];
            return Todo.fromMap(jsonData);
          },
        );
      },
      context: 'updating todo with id: ${todo.id}',
    );
  }

  @override
  Future<Todo> toggleTodo(Todo todo) async {
    return await editTodo(todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    return _execute(
      action: () async {
        final response = await http.delete(
          Uri.parse('$baseUrl/todos/$id'),
        );

        return _handleResponse<void>(
          response,
          (body) {
            return;
          },
        );
      },
      context: 'deleting todo with id: $id',
    );
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(dynamic body) onSuccess,
  ) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      return onSuccess(jsonDecode(response.body));
    }

    switch (statusCode) {
      case 400:
        throw BadRequestException();
      case 404:
        throw ResourceNotFoundException();
      default:
        if (statusCode >= 500) {
          throw ServerException();
        }
        throw UnknownException(
          message: 'Unexpected status code $statusCode: ${response.body}',
        );
    }
  }

  Future<T> _execute<T>({
    required Future<T> Function() action,
    required String context,
  }) async {
    try {
      return await action();
    } on BadRequestException {
      rethrow;
    } on ResourceNotFoundException {
      rethrow;
    } on ServerException {
      rethrow;
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw UnknownException(
        message: 'An error occured while $context: $e',
      );
    }
  }
}
