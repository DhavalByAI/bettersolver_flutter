import 'package:bettersolver/models/privacy_get_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyGetRepository {
  ApiProvider _provider = ApiProvider();

  Future<PrivacyGetModel> fetchprivacy() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=privacy',
      requestBody,
    );

    return PrivacyGetModel.fromJson(response);
  }
}
