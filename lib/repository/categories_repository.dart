import 'package:bettersolver/models/categories_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesRepository {
  ApiProvider _provider = ApiProvider();

  Future<CategoriesModel> fetchCategories(String viewuserid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "user_profile_id": viewuserid,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_my_community',
      requestBody,
    );

    return CategoriesModel.fromJson(response);
  }
}
