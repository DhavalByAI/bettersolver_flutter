import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/models/loginmodel.dart';
import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:bettersolver/utils/base_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  ApiProvider _provider = ApiProvider();

  Future<LoginModel> fetchLogin(String type, String username, String password,
      String s, var fcmToken) async {
    final requestBody = {
      "type": type,
      "username": username,
      "password": password,
      "s": s,
      "fcm_token": fcmToken,
    };
    var response = await _provider.httpMethodWithoutToken('post',
        'demo2/app_api.php?application=phone&type=user_login', requestBody);

    return LoginModel.fromJson(response);
  }
}
