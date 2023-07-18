import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/models/common_data_integer_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeletePostRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonDataIntegerModel> delete_post(String postId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "post_id": postId,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=delete_post',
      requestBody,
    );

    return CommonDataIntegerModel.fromJson(response);
  }
}