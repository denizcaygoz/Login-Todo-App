import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_todo_app/common/bloc/auth/auth_state.dart';
import 'package:login_todo_app/common/bloc/auth/auth_state_cubit.dart';
import 'package:login_todo_app/presentation/auth/pages/signin.dart';
import 'package:login_todo_app/presentation/auth/pages/signup.dart';
import 'package:login_todo_app/presentation/home/pages/todopage.dart';
import 'service_locator.dart';

void main() {
  setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthStateCubit()..appStarted(),
      child: MaterialApp(
          title: 'Login-Todo-App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.yellow[200]),
          home: BlocBuilder<AuthStateCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                //user has already token and no need to sign in again.
                return TodoPage();
              }
              if (state is UnAuthenticated) {
                //user has no or expired token and needs to sign in again.
                return SigninPage();
              }
              return Container();
            },
          )),
    );
  }
}
