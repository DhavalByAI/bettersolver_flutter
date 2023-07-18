import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/home_screen_controller.dart';

class EditPostRepository {
  ApiProvider _provider = ApiProvider();
  Future<CommonDataModel> editPost(
      String postid, String text, String group_id, String title) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    final requestBody = {
      "user_id": userid,
      "s": s,
      "post_id": postid,
      "text": text,
      "group_id": group_id,
      "title": title,
    };
    print(requestBody);

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=edit_post',
      requestBody,
    );

    var api_status = CommonDataModel.fromJson(response).apiText;
    print("apiStatus = ${api_status}");
    if (api_status == "success") {
      HomeScreenController _ = Get.find();
      _.fetchallpost(_.pageno);
    }
    return CommonDataModel.fromJson(response);
  }
}
