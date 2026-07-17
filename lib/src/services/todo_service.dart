import '../models/todo.dart';

abstract interface class TodoService {
  Future<List<Todo>> getTodos();

  Future<Todo> addNewTodo(Todo todo);

  Future<Todo> editTodo(Todo todo);

  Future<Todo> toggleTodo(Todo todo);

  Future<void> deleteTodo(String id);
}
