import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:login_todo_app/data/models/todos.dart';
import 'package:login_todo_app/data/models/signin_req_params.dart';
import 'package:login_todo_app/data/source/auth_api_service.dart';
import 'package:login_todo_app/domain/repository/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/todos.dart';
import '../../service_locator.dart';
import '../database.dart';
import '../models/post_todos_req_params.dart';
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

      //Converting response.data['todos'] to a list of TodosModel
      List<TodosModel> todosList = (response.data['todos'] as List)
          .map((todo) => TodosModel.fromMap(todo))
          .toList();

      //Converting TodosModel list to TodosEntity list
      List<TodosEntity> todosEntityList =
          todosList.map((todo) => todo.toEntity()).toList();

      //Storing the entity list in Hive database
      sl<Box>().put("todolistBox", todosEntityList);

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

  @override
  Future<Either> postTodos(PostTodosReqParams postTodosReqParams) async {
    Either result = await sl<AuthApiService>().postTodos(postTodosReqParams);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;

      //Converting API response to TodosModel list
      List<TodosModel> todosList = (response.data as List)
          .map((todo) => TodosModel.fromMap(todo))
          .toList();

      //Converting model list to entity list
      List<TodosEntity> todosEntityList =
          todosList.map((todo) => todo.toEntity()).toList();

      return Right(todosEntityList);
    });
  }

  @override
  Future<Either> getTodos() async {
    Either result = await sl<AuthApiService>().getTodos();
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      List<TodosModel> todosList = (response.data as List)
          .map((todo) => TodosModel.fromMap(todo))
          .toList();

      List<TodosEntity> todosEntityList =
          todosList.map((todo) => todo.toEntity()).toList();
      return Right(todosEntityList);
    });
  }
}
