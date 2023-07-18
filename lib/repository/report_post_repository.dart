import 'package:bettersolver/models/common_data_integer_model.dart';
import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportPostRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonDataIntegerModel> fetchReportpost(
      String postid, String text) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "post_id": postid,
      "text": text,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=report_post',
      requestBody,
    );

    return CommonDataIntegerModel.fromJson(response);
  }
}
