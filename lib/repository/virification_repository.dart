import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VirificationRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonDataModel> fetchVerification(
      String username, String msg, String pic1, String pic2) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "username": username,
      "message": msg,
      "pic1": pic1,
      "pic2": pic2,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=verification',
      requestBody,
    );

    return CommonDataModel.fromJson(response);
  }
}
