import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../style/palette.dart';
import '../../utils/base_constant.dart';
import 'package:dio/dio.dart' as dio;

import '../home_screen_controller.dart';

class CreatePollController extends GetxController {
  List categoryList = [];
  var categoryType;
  List extraOptions = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  int postPrivacy = 0;
  List<TextEditingController> optionController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  @override
  void onInit() {
    fetchCatList();
    extraOptions.add(_option1(0));
    extraOptions.add(_option1(1));
    update();
    super.onInit();
  }

  getAPI() async {
    EasyLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    String answer = "";
    for (var element in optionController) {
      if (element.text != "") {
        answer = '$answer${element.text},';
      }
    }
    answer = answer.isNotEmpty ? answer.substring(0, answer.length - 1) : "";
    print(answer);
    try {
      Map<String, dynamic> params = {
        "user_id": userid,
        "s": s,
        "title": titleController.text.toString(),
        "postText": captionController.text.toString(),
        "postPrivacy": postPrivacy.toString(),
        "group_id": categoryType.toString(),
        "answer": answer,
      };

      print(params);

      dio.Response response = await dio.Dio().post(
        '${BaseConstant.BASE_URL_DEMO}${BaseConstant.BASE_URL_PARAMS}${BaseConstant.newPost}',
        data: dio.FormData.fromMap(params),
      );
      print(response.data);
      var res = json.decode(response.toString());
      print(res);
      if (res['status'] == "200") {
        EasyLoading.showSuccess("Uploaded Successfully",
            duration: const Duration(milliseconds: 1000),
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true);
        titleController.clear();
        captionController.clear();
        for (var element in optionController) {
          element.clear();
        }
        Get.back();
        HomeScreenController _ = Get.find();
        _.fetchallpost("1");
      } else {
        EasyLoading.showError(res['errors'],
            duration: const Duration(milliseconds: 1000),
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true);
      }
    } catch (e) {
      EasyLoading.showError("Something Went Wrong");
    }
    update();
  }

  fetchCatList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userid');
    var s = pref.getString('s');

    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=get_group';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId,
          's': s,
        },
      );

      var decode = json.decode(response.body);
      print(decode);

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        if (decode['api_status'] == '200') {
          categoryList = decode['group'];
        } else {
          categoryList = [];
        }
      } else {}
    } catch (e) {
      EasyLoading.showError("Something Went Wrong");
    }
    update();
  }

  Widget _option1(int index) {
    return GetBuilder<CreatePollController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: _.optionController[index],
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Option ${index + 1}",
              hintStyle: Palette.greytext12,
              labelStyle: GoogleFonts.roboto(color: Colors.grey),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
