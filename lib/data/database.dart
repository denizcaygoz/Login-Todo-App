import 'package:hive/hive.dart';
import 'package:login_todo_app/domain/entities/todos.dart';

import '../service_locator.dart';

class ToDoDataBase {
  List<TodosEntity> toDoList = [];

  final _todoBox = sl<Box>();

  void createInitialData() {
    toDoList = [
      TodosEntity(task: "Do homework", completed: false),
      TodosEntity(task: "Go to GYM", completed: false),
    ];
  }

  void loadData() {
    toDoList = _todoBox.get("todolistBox");
  }

  void updateData() {
    _todoBox.put("todolistBox", toDoList);
  }

  Map<String, dynamic> toMap() {
    return {
      'todos': toDoList
          .map((todo) => todo.toMap())
          .toList(), //Converting each entity into a map
    };
  }
}
