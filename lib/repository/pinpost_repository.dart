import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinPostRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonDataModel> fetchpinpost(String postid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "post_id": postid,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=pinned_post',
      requestBody,
    );

    return CommonDataModel.fromJson(response);
  }
}
