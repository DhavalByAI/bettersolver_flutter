import 'package:bettersolver/models/user_timeline_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTimelineRepository {
  ApiProvider _provider = ApiProvider();

  Future<UserTimeLineModel> fetchUsertimeline(
      String pageno, String viewuserid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "user_profile_id": viewuserid,
      "page_no": pageno,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_user_posts',
      requestBody,
    );

    return UserTimeLineModel.fromJson(response);
  }
}
