import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/category_details_model.dart';
import '../../models/commondata_model.dart';
import '../../utils/apiprovider.dart';

class CategoryDetailController extends GetxController {
  final ApiProvider _provider = ApiProvider();
  String groupid = "";
  CategoryDetailsModel model = CategoryDetailsModel();
  fetchcategorydetails() async {
    EasyLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "group_profile_id": groupid
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_group_data',
      requestBody,
    );
    var res = CategoryDetailsModel.fromJson(response);
    res.apiStatus == '200'
        ? model = res
        : EasyLoading.showError("Something Went Wrong");
    update();
    EasyLoading.dismiss();
  }

  fetchjoingroup() async {
    EasyLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "s": s,
      "group_id": groupid,
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=join_group',
      requestBody,
    );
    var rs = CommonDataModel.fromJson(response);
    rs.apiStatus == '200'
        ? fetchcategorydetails()
        : EasyLoading.showError("Something Went Wrong");
  }
}
