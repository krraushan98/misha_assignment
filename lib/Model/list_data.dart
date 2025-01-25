import 'package:shared_preferences/shared_preferences.dart';

class Task {
  String title;
  String description;
  DateTime time;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.time,
    this.isCompleted = false,
  });

  
  String toStorageString() {
    return '$title|$description|${time.toIso8601String()}|$isCompleted';
  }

  
  factory Task.fromStorageString(String storedTask) {
    List<String> data = storedTask.split('|');
    return Task(
      title: data[0],
      description: data[1],
      time: DateTime.parse(data[2]),
      isCompleted: data[3] == 'true',
    );
  }
}
