import 'package:bettersolver/models/blocked_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlockedRepository {
  ApiProvider _provider = ApiProvider();

  Future<BlockedModel> fetchBlocked(String blockeduserid, String type) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "recipient_id": blockeduserid,
      "block_type": type,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=block_user',
      requestBody,
    );

    return BlockedModel.fromJson(response);
  }
}
