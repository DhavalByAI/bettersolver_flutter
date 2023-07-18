import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/base_constant.dart';

class PostViewController extends GetxController {
  List posts = [];

  fetchAPI(String postId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userid');
    var s = pref.getString('s');
    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=get_post_data';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId,
          's': s,
          'post_id': postId,
        },
      );

      var decode = json.decode(response.body);
      print(decode);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        if (decode['api_status'] == '200') {
          posts.clear();
          posts.add(decode['post_data']);
        } else {}
      } else {}
    } catch (e) {
      EasyLoading.showError("Something Went Wrong");
    }
    update();
  }
}
