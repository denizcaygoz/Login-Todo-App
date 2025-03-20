import 'package:hive/hive.dart';

import '../service_locator.dart';

class ToDoDataBase {
  List toDoList = [];

  final _todoBox = sl<Box>();

  void createInitialData() {
    toDoList = [
      ["Do homework", false],
      ["Go to GYM", false]
    ];
  }

  void loadData() {
    toDoList = _todoBox.get("todolistBox");
  }

  void updateData() {
    _todoBox.put("todolistBox", toDoList);
  }
}
