import 'package:bettersolver/models/following_models.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowingRepository {
  ApiProvider _provider = ApiProvider();

  Future<FollowingModel> fetchFollowingData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {"user_id": userid, "s": s};

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_users_friends',
      requestBody,
    );

    return FollowingModel.fromJson(response);
  }
}
