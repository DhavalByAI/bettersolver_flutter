import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialLinksUpdateRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonModel> fetchsociallinksupdate(String facebook, String twitter,
      String youtube, String linkedin, String instagram) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "type": 'profile_settings',
      "facebook": facebook,
      "twitter": twitter,
      "youtube": youtube,
      "linkedin": linkedin,
      "instagram": instagram,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=update_user_data',
      requestBody,
    );

    return CommonModel.fromJson(response);
  }
}
