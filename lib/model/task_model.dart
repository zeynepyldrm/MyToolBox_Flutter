class Task {
  final String task;
  final DateTime dateTime;

  Task({required this.task, required this.dateTime});
  Map<String, dynamic> toMap() {
    return ({'task': task, 'createdDate': dateTime.toString()});
  }
}
