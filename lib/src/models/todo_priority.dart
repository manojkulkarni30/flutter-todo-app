enum TodoPriority {
  low,
  medium,
  high,
  urgent;

  String get name {
    switch (this) {
      case TodoPriority.low:
        return 'Low';
      case TodoPriority.medium:
        return 'Medium';
      case TodoPriority.high:
        return 'High';
      case TodoPriority.urgent:
        return 'Urgent';
    }
  }

  int toMap() => index;

  static TodoPriority fromMap(int? value) {
    return TodoPriority.values.firstWhere(
      (e) => e.index == value,
      orElse: () => TodoPriority.medium,
    );
  }
}
