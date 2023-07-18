import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfileRepository {
  ApiProvider _provider = ApiProvider();

  Future<UserDetailModel> fetchViewUserDetail(String viewuserid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "user_profile_id": viewuserid,
      "s": s
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_user_data',
      requestBody,
    );
    print(response);

    return UserDetailModel.fromJson(response);
  }
}
