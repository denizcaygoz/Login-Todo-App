import 'package:shared_preferences/shared_preferences.dart';
import '../../service_locator.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
}

class AuthLocalServiceImpl extends AuthLocalService {
  @override
  Future<bool> isLoggedIn() async {
    var jwtToken = sl<SharedPreferences>().getString('jwtToken');
    if (jwtToken == null) {
      return false;
    } else {
      return true;
    }
  }
}
