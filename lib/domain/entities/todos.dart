class TodosEntity {
  final String task;
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
