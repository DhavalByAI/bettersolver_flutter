import 'package:bettersolver/models/comment_post_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentPostRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommentPostModel> fetchCommentPost(
    String postid,
    String commenttext,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "post_id": postid,
      "text": commenttext,
      "hash": 'fcab40bcb97a6638f86a',
      "page_id": '0',
      "audio": '',
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=comment_post',
      requestBody,
    );

    return CommentPostModel.fromJson(response);
  }
}
