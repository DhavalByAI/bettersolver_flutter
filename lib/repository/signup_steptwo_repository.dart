import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/utils/apiprovider.dart';

class SignupStepTwoRepository {
  ApiProvider _provider = ApiProvider();

  Future<CommonModel> fetchSignupsteptwo(
    String type,
    String userid,
    String s,
    String username,
    String dob,
    String countryid,
    String occupation,
    String fname,
  ) async {
    final requestBody = {
      "type": type,
      "user_id": userid,
      "s": s,
      "username": username,
      "birthday": dob,
      "country": countryid,
      "occupation": occupation,
      "firstname": fname,
    };

    final response = await _provider.httpMethodWithoutToken(
        'post',
        'demo2/app_api.php?application=phone&type=update_user_data',
        requestBody);

    return CommonModel.fromJson(response);
  }
}
