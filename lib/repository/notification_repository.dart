import 'package:bettersolver/models/notification_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepository {
  final ApiProvider _provider = ApiProvider();

  Future<NotificationModel> fetchNotification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {"user_id": userid, "s": s};

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_notifications',
      requestBody,
    );

    return NotificationModel.fromJson(response);
  }
}
