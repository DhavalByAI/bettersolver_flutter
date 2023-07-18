import 'package:bettersolver/models/my_activities_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyActivitiesRepository {
  ApiProvider _provider = ApiProvider();

  Future<MyActivitesModel> fetchmtactivities() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "before_activity_id": '0',
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_activities',
      requestBody,
    );

    return MyActivitesModel.fromJson(response);
  }
}
