import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/post_todos_req_params.dart';
import '../../service_locator.dart';
import '../repository/auth.dart';

class PostTodosUseCase implements UseCase<Either, PostTodosReqParams> {
  @override
  Future<Either> call({PostTodosReqParams? param}) async {
    return sl<AuthRepository>().postTodos(param!);
  }
}
