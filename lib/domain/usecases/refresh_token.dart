import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../../service_locator.dart';
import '../repository/auth.dart';

class RefreshTokenUseCase implements UseCase<Either, dynamic> {
  //calling the signup method in data/repository/auth.dart
  @override
  Future<Either> call({dynamic param}) async {
    return sl<AuthRepository>().refreshToken();
  }
}
