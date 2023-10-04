import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteRepository {
  final ApiProvider _provider = ApiProvider();

  Future<CommonModel> fetchdelete() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=delete_user',
      requestBody,
    );

    return CommonModel.fromJson(response);
  }
}
