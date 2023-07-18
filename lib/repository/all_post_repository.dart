import 'package:bettersolver/models/all_post_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllpostRepository {
  ApiProvider _provider = ApiProvider();

  Future<AllPostModel> fetchallpost(String pageno) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "page_no": pageno,
    };
    print(requestBody);
    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_post_all',
      requestBody,
    );
    return AllPostModel.fromJson(response);
  }
}
