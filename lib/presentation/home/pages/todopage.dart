import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:login_todo_app/common/widgets/dialog/dialog_box.dart';
import 'package:login_todo_app/data/database.dart';
import 'package:login_todo_app/domain/usecases/post_todos.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/post_todos_req_params.dart';
import '../../../domain/entities/todo_tile.dart';
import '../../../domain/entities/todos.dart';
import '../../../domain/usecases/refresh_token.dart';
import '../../../service_locator.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _controller = TextEditingController();
  final todosBox = sl<Box>();
  ToDoDataBase db = sl<ToDoDataBase>();

  @override
  void initState() {
    startTokenRequest();
    if (todosBox.get("todolistBox") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  @override
  void dispose() {
    postTodosToServer();
    super.dispose();
  }

  void postTodosToServer() {
    final postTodosParams = PostTodosReqParams(
      todos: db.toDoList.map((todo) => todo.toMap()).toList(),
    );
    sl<PostTodosUseCase>().call(param: postTodosParams);
  }

  // Send periodically token request to server.
  // Refresh token sent and set to the recieved token to shared pref jwtToken
  void startTokenRequest() {
    Timer.periodic(Duration(minutes: 15), (Timer timer) async {
      await sl<RefreshTokenUseCase>().call();
    });
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index].completed = !db.toDoList[index].completed;
    });
    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add(TodosEntity(task: _controller.text, completed: false));
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(child: const Text('Today\'s Tasks')),
        elevation: 0,
        leading: Align(
          alignment: Alignment.center,
          child: Text(
            sl<SharedPreferences>().getString('username') ?? 'User',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index].getTask,
            taskCompleted: db.toDoList[index].isCompleted,
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
