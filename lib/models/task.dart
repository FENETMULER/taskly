class Task {
  Task({required this.id, required this.title, bool? checked})
      : checked = checked ?? false;

  final String id;
  final String title;
  bool checked;
}
