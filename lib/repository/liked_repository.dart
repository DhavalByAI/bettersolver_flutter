import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/screen/ListOfPosts_controller.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikedRepository {
  final ApiProvider _provider = ApiProvider();

  Future<CommonModel> fetchLiked(
      String postid, String reaction, bool isDelete, String url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = isDelete
        ? {
            "user_id": userid,
            "s": s,
            "post_id": postid,
            "reaction_id": reaction
          }
        : {"user_id": userid, "s": s, "post_id": postid, "reaction": reaction};

    final response = await _provider.httpMethodWithoutToken(
      'post',
      isDelete
          ? 'demo2/app_api.php?application=phone&type=delete_reaction_post'
          : 'demo2/app_api.php?application=phone&type=register_reaction_post',
      requestBody,
    );
    ListOfPostsController _ = Get.find();
    _.fetchallpost(_.pageno, url);
    return CommonModel.fromJson(response);
  }
}
