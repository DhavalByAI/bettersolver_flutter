import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';

class SignupStepFollowRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonDataModel> fetchFolloweduser(
      String userid, String s, String recipientId) async {
    final requestBody = {
      "user_id": userid,
      "s": s,
      "recipient_id": recipientId
    };

    final response = await _provider.httpMethodWithoutToken('post',
        'demo2/app_api.php?application=phone&type=follow_user', requestBody);

    return CommonDataModel.fromJson(response);
  }
}
