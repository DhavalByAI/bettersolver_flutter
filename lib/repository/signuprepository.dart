import 'package:bettersolver/models/signupmodel.dart';
import 'package:bettersolver/utils/apiprovider.dart';

class SignupRepository {
  ApiProvider _provider = ApiProvider();

  Future<SignUpModel> fetchSign(
    String email,
    String fname,
    String lname,
    String password,
    String byear,
    String bmonth,
    String bday,
    String gender,
    String emailorsms,
    String s,
      var fcmToken
  ) async {
    print('signuprepository fcm token --$fcmToken');
    final requestBody = {
      'email': email,
      'firstname': fname,
      'surname': lname,
      'password': password,
      'year': byear,
      'month': bmonth,
      'day': bday,
      'gender': gender,
      'sms_or_email': emailorsms,
      's': s,
      'fcmToken':fcmToken
    };

    final respones = await _provider.httpMethodWithoutToken(
        'post',
        'demo2/app_api.php?application=phone&type=user_registration',
        requestBody);

    return SignUpModel.fromJson(respones);
  }
}
