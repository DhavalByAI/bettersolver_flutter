import 'package:bettersolver/models/search_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepository {
  ApiProvider _provider = ApiProvider();

  Future<SearchModel> fetchSearch(String searchType , String text) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "search_type": searchType,
      "text": text,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=search',
      requestBody,
    );

    return SearchModel.fromJson(response);

  }
}