import 'package:bettersolver/models/common_data_integer_model.dart';
import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/models/home_comment_list_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCommentRepository {

  ApiProvider _provider = ApiProvider();
  Future<HomeCommentListModel> fetchHomeComment(
      String postid
      ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    final requestBody = {
      "user_id" : userid,
      "s" : s,
      "post_id" : postid,
    };
    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_post_data',
      requestBody,
    );

    return HomeCommentListModel.fromJson(response);
  }



}