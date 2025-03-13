import 'package:flutter/material.dart';
import 'package:login_todo_app/presentation/auth/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login-Todo-App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.yellow[200]),
      home: SigninPage(),
    );
  }
}
