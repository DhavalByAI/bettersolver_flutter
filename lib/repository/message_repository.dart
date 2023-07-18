import 'package:bettersolver/models/message_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageRepository {
  ApiProvider _provider = ApiProvider();

  Future<MessageModel> fetchMEssage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    print('$s / $userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=chat_list',
      requestBody,
    );

    return MessageModel.fromJson(response);
  }
}
