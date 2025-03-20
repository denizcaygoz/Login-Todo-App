import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_todo_app/data/models/post_todos_req_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/api_urls.dart';
import '../../core/network/dio_client.dart';
import '../../service_locator.dart';
import '../models/signin_req_params.dart';
import '../models/signup_req_params.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReqParams);
  Future<Either> signin(SigninReqParams signinReqParams);
  Future<Either> refreshToken();
  Future<Either> postTodos(PostTodosReqParams postTodosReqParams);
  Future<Either> getTodos();
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup(SignupReqParams signupReqParams) async {
    try {
      var response = await sl<DioClient>()
          .post(ApiUrls.register, data: signupReqParams.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signin(signinReqParams) async {
    try {
      var response = await sl<DioClient>()
          .post(ApiUrls.signin, data: signinReqParams.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> refreshToken() async {
    var prefs = sl<SharedPreferences>();
    var token = prefs.getString("jwtToken");
    try {
      var response = await sl<DioClient>().post(ApiUrls.refreshToken,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> postTodos(PostTodosReqParams postTodosReqParams) async {
    var prefs = sl<SharedPreferences>();
    var token = prefs.getString("jwtToken");
    try {
      var response = await sl<DioClient>().post(ApiUrls.postTodos,
          data: postTodosReqParams.toMap(),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getTodos() async {
    var prefs = sl<SharedPreferences>();
    var token = prefs.getString("jwtToken");
    try {
      var response = await sl<DioClient>().post(ApiUrls.getTodos,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
