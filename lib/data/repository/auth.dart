import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_todo_app/data/source/auth_api_service.dart';
import 'package:login_todo_app/domain/repository/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service_locator.dart';
import '../models/signup_req_params.dart';
import '../source/auth_local_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  //calling the method from data/source folder and then convert the result to model
  @override
  Future<Either> signup(SignupReqParams signupReqParams) async {
    Either result = await sl<AuthApiService>().signup(signupReqParams);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('jwtToken', response.data['jwtToken']);
      return Right(response);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }
}
