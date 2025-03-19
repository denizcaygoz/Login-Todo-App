import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
}

class AuthLocalServiceImpl extends AuthLocalService {
  @override
  Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwtToken = sharedPreferences.getString('jwtToken');
    if (jwtToken == null) {
      return false;
    } else {
      return true;
    }
  }
}
