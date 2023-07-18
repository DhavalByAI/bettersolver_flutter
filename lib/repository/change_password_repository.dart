import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonModel> fetchchangepasssword(
    String currentpass,
    String newpass,
    String repetpass,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "type": 'password_settings',
      "current_password": currentpass,
      "new_password": newpass,
      "repeat_new_password": repetpass,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=update_user_data',
      requestBody,
    );

    return CommonModel.fromJson(response);
  }
}
