import 'package:dartz/dartz.dart';
import 'package:login_todo_app/data/models/signup_req_params.dart';
import '../../data/models/post_todos_req_params.dart';
import '../../data/models/signin_req_params.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupReqParams signupReqParams);
  Future<bool> isLoggedIn();
  Future<Either> signin(SigninReqParams signinReqParams);
  Future<Either> refreshToken();
  Future<Either> postTodos(PostTodosReqParams postTodosReqParams);
  Future<Either> getTodos();
}
