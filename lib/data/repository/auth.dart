import 'package:dartz/dartz.dart';
import 'package:login_todo_app/data/source/auth_api_service.dart';
import 'package:login_todo_app/domain/repository/auth.dart';
import '../../service_locator.dart';
import '../models/signup_req_params.dart';

class AuthRepositoryImpl extends AuthRepository {
  //calling the method from data/source folder and then convert the result to model
  @override
  Future<Either> signup(SignupReqParams signupReqParams) async {
    return sl<AuthApiService>().signup(signupReqParams);
  }
}
