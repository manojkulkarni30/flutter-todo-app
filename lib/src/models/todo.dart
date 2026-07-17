import 'dart:convert';

import 'todo_category.dart';
import 'todo_priority.dart';

class Todo {
  factory Todo.create({
    required String title,
    String? description,
    TodoCategory category = TodoCategory.general,
    TodoPriority priority = TodoPriority.medium,
    bool isCompleted = false,
    DateTime? dueDate,
    DateTime? reminderDate,
  }) {
    return Todo(
      title: title,
      description: description,
      isCompleted: isCompleted,
      category: category,
      priority: priority,
      dueDate: dueDate,
      reminderDate: reminderDate,
    );
  }
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'],
      isCompleted: map['isCompleted'] ?? false,
      category: TodoCategory.fromMap(map['category']),
      priority: TodoPriority.fromMap(map['priority']),
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      reminderDate: map['reminderDate'] != null
          ? DateTime.parse(map['reminderDate'])
          : null,
      dateCreated: map['dateCreated'] != null
          ? DateTime.parse(map['dateCreated'])
          : null,
      dateUpdated: map['dateUpdated'] != null
          ? DateTime.parse(map['dateUpdated'])
          : null,
    );
  }

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  const Todo({
    this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.category,
    required this.priority,
    this.dueDate,
    this.reminderDate,
    this.dateCreated,
    this.dateUpdated,
  });

  final String? id;
  final String title;
  final String? description;
  final bool isCompleted;
  final TodoCategory category;
  final TodoPriority priority;
  final DateTime? dueDate;
  final DateTime? reminderDate;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'category': category.toMap(),
      'priority': priority.toMap(),
      'dueDate': dueDate?.toIso8601String(),
      'reminderDate': reminderDate?.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    TodoCategory? category,
    TodoPriority? priority,
    DateTime? dueDate,
    DateTime? reminderDate,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      reminderDate: reminderDate ?? this.reminderDate,
    );
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, isCompleted: $isCompleted, category: $category, priority: $priority, dueDate: $dueDate, reminderDate: $reminderDate, dateCreated: $dateCreated, dateUpdated: $dateUpdated)';
  }
}
