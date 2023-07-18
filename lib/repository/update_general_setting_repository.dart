import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateGeneralSettingRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonModel> fetchgeneralsetting(
    String email,
    String number,
    String gender,
    String username,
    String dob,
    String countryid,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "type": 'general_settings',
      "user_id": userid,
      "s": s,
      "email": email,
      "phone_number": number,
      "gender": gender,
      "username": username,
      "birthday": dob,
      "country": countryid,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=update_user_data',
      requestBody,
    );

    return CommonModel.fromJson(response);
  }
}
