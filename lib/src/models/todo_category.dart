enum TodoCategory {
  general,
  work,
  personal,
  finances,
  health;

  String get name {
    switch (this) {
      case TodoCategory.general:
        return 'General';
      case TodoCategory.work:
        return 'Work';
      case TodoCategory.personal:
        return 'Personal';
      case TodoCategory.finances:
        return 'Finances';
      case TodoCategory.health:
        return 'Health';
    }
  }

  int toMap() => index;

  static TodoCategory fromMap(int? value) {
    return TodoCategory.values.firstWhere(
      (e) => e.index == value,
      orElse: () => TodoCategory.general,
    );
  }
}
