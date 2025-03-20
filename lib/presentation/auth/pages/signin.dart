import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_todo_app/presentation/auth/pages/signup.dart';

import '../../../common/bloc/button/button_state.dart';
import '../../../common/bloc/button/button_state_cubit.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import '../../../data/models/signin_req_params.dart';
import '../../../domain/usecases/signin.dart';
import '../../../service_locator.dart';
import '../../home/pages/todopage.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

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
                  MaterialPageRoute(builder: (context) => const TodoPage()),
                );
              } else if (state is ButtonFailureState) {
                var snackBar = SnackBar(content: Text(state.errorMessage));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 50, right: 50, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 100,
                  ),
                  TextField(
                    controller: _usernameCon,
                    decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.text_fields)),
                  ),
                  TextField(
                    controller: _passwordCon,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => (),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  _createAccountButton(context),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1, // Adjust line thickness
                          color: Colors.grey, // Line color
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10), // Space around text
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey), // Text color
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () => (),
                      child: Icon(
                        FontAwesomeIcons.google,
                        size: 30,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _createAccountButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: BasicAppButton(
            title: "Sign In",
            onPressed: () {
              context.read<ButtonStateCubit>().execute(
                    usecase: sl<SigninUseCase>(),
                    params: SigninReqParams(
                      username: _usernameCon.text,
                      password: _passwordCon.text,
                    ),
                  );
            },
          ),
        );
      },
    );
  }
}
