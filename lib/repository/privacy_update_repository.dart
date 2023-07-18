import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyUpdateRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonDataModel> fetchprivacy(
    String followMe,
    String messagewMe,
    String myFollowers,
    String myTimeline,
    String mydob,
    String visitProfile,
    String myactivities,
    String myStatus,
    String livePublic,
    String search,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "follow_privacy": followMe,
      "message_privacy": messagewMe,
      "friend_privacy": myFollowers,
      "post_privacy": myTimeline,
      "birth_privacy": mydob,
      "visit_privacy": visitProfile,
      "show_activities_privacy": myactivities,
      "status": myStatus,
      "share_my_location": livePublic,
      "share_my_data": search,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=privacy_update',
      requestBody,
    );

    return CommonDataModel.fromJson(response);
  }
}
