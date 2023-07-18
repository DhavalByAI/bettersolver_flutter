import 'package:bettersolver/models/categories_model.dart';
import 'package:bettersolver/models/category_details_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryDetailsRepository {
  final ApiProvider _provider = ApiProvider();

  Future<CategoryDetailsModel> fetchcategorydetails(String groupid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "group_profile_id": groupid
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_group_data',
      requestBody,
    );

    return CategoryDetailsModel.fromJson(response);
  }
}
