import 'dart:convert';

import 'package:bettersolver/bloc/viewprofile_bloc.dart';
import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:bettersolver/utils/base_constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfileController extends GetxController {
  ViewProfileBloc? _viewProfileBloc;
  final ApiProvider _provider = ApiProvider();

  UserDetailModel? userDetailModel;
  doFollow(
    String followID,
  ) async {
    EasyLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=follow_user';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userid,
          's': s,
          'recipient_id': followID,
        },
      );
      var res = json.decode(response.body);
      if (res['api_status'] == "200") {
        print(res);
        userDetailModel = await fetchViewUserDetail(followID);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
    update();
  }

  Future<UserDetailModel> fetchViewUserDetail(String viewuserid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "user_profile_id": viewuserid,
      "s": s
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_user_data',
      requestBody,
    );
    print(response);
    return UserDetailModel.fromJson(response);
  }

  userReport(String viewuserid) async {
    EasyLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');

    final requestBody = {
      "user_id": userid,
      "profile_id": viewuserid,
      "s": s,
      'text': 'user report api'
    };

    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=user_report',
      requestBody,
    );
    var res = CommonDataModel.fromJson(response);
    if (res.apiStatus == 200) {
      EasyLoading.showSuccess(res.data);
      fetchViewUserDetail(viewuserid);
    } else {
      EasyLoading.showError("Something Went Wrong");
    }
    update();
  }
}
