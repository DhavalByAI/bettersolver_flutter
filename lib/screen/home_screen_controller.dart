import 'dart:convert';
import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import 'package:bettersolver/models/all_post_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/all_post_bloc.dart';
import '../utils/base_constant.dart';

class HomeScreenController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List categoryList = [];

  void onRefresh() async {
    log("onRefresh()");
    await Future.delayed(Duration(milliseconds: 500));
    fetchallpost("1");
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    log("onLoading()");
    await Future.delayed(Duration(milliseconds: 500));
    pageno = (int.parse(pageno) + 1).toString();
    await fetchallpost(pageno);
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    fetchallpost("1");
    // scrollController.addListener(() {
    //   if (scrollController.position.atEdge) {
    //     if (scrollController.position.pixels == 0) {
    //     } else {
    //       print('list scroll at bottom');
    //       try {
    //         pageno = (int.parse(pageno) + 1).toString();
    //         isLoading = true;
    //         update();
    //         fetchallpost(pageno);
    //       } catch (e) {
    //         debugPrint('Error: $e');
    //       }
    //     }
    //   }
    // });
    super.onInit();
  }

  String pageno = "1";
  bool isLoading = false;
  AllpostBloc? allpostBloc;
  // AllPostModel? allPostModel;
  ScrollController scrollController = ScrollController();
  List posts = [];
  // ApiProvider _provider = ApiProvider();

  fetchallpost(String pageno) async {
    isLoading = false;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    final requestBody = {
      "user_id": userid,
      "s": s,
      "page_no": pageno,
    };

    final response = await ApiProvider().httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=get_post_all',
      requestBody,
    );
    var data = AllPostModel.fromJson(response);
    if (data.apiStatus == "200") {
      if (pageno == '1') {
        posts.clear();
        posts.addAll(data.posts);
      } else {
        posts.addAll(data.posts);
      }
    }

    isLoading = true;
    update();
  }
}
