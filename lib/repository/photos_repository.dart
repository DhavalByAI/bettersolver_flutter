import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotosRepositpry {
  ApiProvider _provider = ApiProvider();

  Future<CommonDataModel> fetchPhoto(String profileid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "profile_id": profileid,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=user_photos',
      requestBody,
    );

    return CommonDataModel.fromJson(response);
  }
}
