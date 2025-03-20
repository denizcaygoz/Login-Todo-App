import '../../domain/entities/todos.dart';

class TodosModel {
  final String task;
  final bool completed;

  TodosModel({
    required this.task,
    required this.completed,
  });

  factory TodosModel.fromMap(Map<String, dynamic> map) {
    return TodosModel(
      task: map['task'] as String,
      completed: map['completed'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task': task,
      'completed': completed,
    };
  }
}

extension TodosModelX on TodosModel {
  TodosEntity toEntity() {
    return TodosEntity(
      task: task,
      completed: completed,
    );
  }
}
