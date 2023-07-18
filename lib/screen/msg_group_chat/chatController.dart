import 'package:bettersolver/utils/apiprovider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  ApiProvider _provider = ApiProvider();
  List messages = [];

  fetchMEssage(String ID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    print('$s / $userid');
    final requestBody = {
      "user_id": userid,
      "recipient_id": ID,
      "s": s,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_user_messages',
      requestBody,
    );
    messages = response['messages'].reversed.toList();
    print(response);
    update();
  }

  sendMessage({required String ID, required String text}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    print('$s / $userid');
    final requestBody = {
      "user_id": userid,
      "recipient_id": ID,
      "s": s,
      "send_time": "12:25",
      "text": text,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=insert_new_message',
      requestBody,
    );
    if (response['api_text'] == "success") {
      fetchMEssage(ID);
    }
    // messages = response['messages'];
    // print(response);
    update();
  }
}
