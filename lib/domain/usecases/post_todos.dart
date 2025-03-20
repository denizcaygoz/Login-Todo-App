import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/post_todos_req_params.dart';
import '../../service_locator.dart';
import '../repository/auth.dart';

class SigninUseCase implements UseCase<Either, PostTodosReqParams> {
  //calling the signup method in data/repository/auth.dart
  @override
  Future<Either> call({PostTodosReqParams? param}) async {
    return sl<AuthRepository>().postTodos(param!);
  }
}
