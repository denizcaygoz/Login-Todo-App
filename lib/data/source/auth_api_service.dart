import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/constants/api_urls.dart';
import '../../core/network/dio_client.dart';
import '../../service_locator.dart';
import '../models/signup_req_params.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReqParams);
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
}
