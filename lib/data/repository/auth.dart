import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:login_todo_app/data/models/signin_req_params.dart';
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
      sl<SharedPreferences>().setString('jwtToken', response.data['jwtToken']);
      sl<SharedPreferences>().setString('username', response.data['username']);
      return Right(response);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either> signin(SigninReqParams signinReqParams) async {
    Either result = await sl<AuthApiService>().signin(signinReqParams);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      sl<SharedPreferences>().setString('jwtToken', response.data['jwtToken']);
      sl<SharedPreferences>().setString('username', response.data['username']);
      sl<Box>().clear();
      sl<Box>().put("todolistBox", response.data['todos']);
      return Right(response);
    });
  }

  @override
  Future<Either> refreshToken() async {
    Either result = await sl<AuthApiService>().refreshToken();
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      sl<SharedPreferences>().setString('jwtToken', response.data['jwtToken']);
      return Right(response);
    });
  }
}
