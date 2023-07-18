import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';

class FamousUserRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonDataModel> fetchFamousUser(String userid, String s) async {
    final requestBody = {"user_id": userid, "s": s};

    final response = await _provider.httpMethodWithoutToken('post',
        'demo2/app_api.php?application=phone&type=famous_user', requestBody);

    return CommonDataModel.fromJson(response);
  }
}
