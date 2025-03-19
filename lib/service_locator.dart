import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:login_todo_app/core/network/dio_client.dart';
import 'package:login_todo_app/data/source/auth_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import 'data/repository/auth.dart';
import 'data/source/auth_local_service.dart';
import 'domain/repository/auth.dart';
import 'domain/usecases/is_logged_in.dart';
import 'domain/usecases/signup.dart';

final sl = GetIt.instance;

Future<void> setUpServiceLocator() async {
  Hive.init('hive_storage');
  final todoListBox = await Hive.openBox('todolistBox');

  sl.registerSingleton<Box>(todoListBox);

  final prefs = await SharedPreferences.getInstance();

  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
}
