import 'package:bettersolver/models/category_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryRepository {
  ApiProvider _provider = ApiProvider();

  Future<CategoryModel> fetchcategory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {"user_id": userid, "s": s};

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_group',
      requestBody,
    );

    return CategoryModel.fromJson(response);
  }
}
