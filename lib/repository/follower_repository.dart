import 'package:bettersolver/models/follower_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowerRepository {
  ApiProvider _provider = ApiProvider();

  Future<FollowerModel> fetchFollowerData(String uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');

    final requestBody = {"user_id": uid, "s": s};

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_follower_user',
      requestBody,
    );

    return FollowerModel.fromJson(response);
  }
}
