import 'package:dartz/dartz.dart';
import 'package:login_todo_app/data/models/signup_req_params.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupReqParams signupReqParams);
  Future<bool> isLoggedIn();
}
