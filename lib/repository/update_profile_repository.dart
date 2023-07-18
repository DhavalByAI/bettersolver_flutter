import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonModel> fetchupdateprofile(
      String fname,
      String lname,
      String bio,
      String address,
      String occupation,
      String websiteLink,
      String website,
      String otheroccupation) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "type": 'profile_settings',
      "user_id": userid,
      "s": s,
      "first_name": fname,
      "last_name": lname,
      "about": bio,
      "address": address,
      "occupation": occupation,
      "working_link": websiteLink,
      "website": website,
      "occupation_other": otheroccupation,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=update_user_data',
      requestBody,
    );

    return CommonModel.fromJson(response);
  }
}
