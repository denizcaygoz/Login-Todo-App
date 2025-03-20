import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../../service_locator.dart';
import '../repository/auth.dart';

class GetTodosUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<AuthRepository>().getTodos();
  }
}
