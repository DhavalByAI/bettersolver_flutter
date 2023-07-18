import 'package:bettersolver/models/save_post_list_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavePostListRepository {
  ApiProvider _provider = ApiProvider();

  Future<SavePostListModel> fetchsavepostlist() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "page_no": '1',
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_saved_posts',
      requestBody,
    );

    return SavePostListModel.fromJson(response);
  }
}
