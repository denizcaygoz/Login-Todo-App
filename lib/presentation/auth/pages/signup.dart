import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_todo_app/common/bloc/button/button_state.dart';
import 'package:login_todo_app/common/bloc/button/button_state_cubit.dart';
import 'package:login_todo_app/common/widgets/button/basic_app_button.dart';
import 'package:login_todo_app/data/models/signup_req_params.dart';
import 'package:login_todo_app/domain/usecases/signup.dart';
import 'package:login_todo_app/presentation/auth/pages/signin.dart';
import 'package:login_todo_app/service_locator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _repeatedPassCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SigninPage()),
              );
            } else if (state is ButtonFailureState) {
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: SafeArea(
            minimum: const EdgeInsets.only(top: 50, right: 16, left: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _signupIcon(),
                  const SizedBox(height: 20),
                  _userNameField(),
                  const SizedBox(height: 15),
                  _emailField(),
                  const SizedBox(height: 15),
                  _passwordField(),
                  const SizedBox(height: 15),
                  _repeatPasswordField(),
                  const SizedBox(height: 40),
                  _createAccountButton(context),
                  const SizedBox(height: 20),
                  _signinText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signupIcon() {
    return const Icon(
      Icons.person,
      size: 100,
    );
  }

  Widget _userNameField() {
    return TextField(
      controller: _usernameCon,
      decoration: const InputDecoration(
        hintText: "Username",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.text_fields),
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(
        hintText: "Email",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.text_fields),
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordCon,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }

  Widget _repeatPasswordField() {
    return TextField(
      controller: _repeatedPassCon,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Repeat Password",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: BasicAppButton(
            title: "Sign Up",
            onPressed: () {
              context.read<ButtonStateCubit>().execute(
                    usecase: sl<SignupUseCase>(),
                    params: SignupReqParams(
                      username: _usernameCon.text,
                      email: _emailCon.text,
                      password: _passwordCon.text,
                    ),
                  );
            },
          ),
        );
      },
    );
  }

  Widget _signinText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SigninPage()),
            );
          },
          child: const Text(
            " Sign In",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
