import 'package:hive/hive.dart';
//part 'todos.g.dart';

@HiveType(typeId: 1)
class TodosEntity {
  @HiveField(0)
  final String task;

  @HiveField(1)
  bool completed;

  TodosEntity({
    required this.task,
    required this.completed,
  });

  String get getTask => task;

  bool get isCompleted => completed;

  Map<String, dynamic> toMap() {
    return {
      'task': task,
      'completed': completed,
    };
  }
}
