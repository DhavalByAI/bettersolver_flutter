import 'dart:convert';
import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:bettersolver/bloc/all_post_bloc.dart';
import 'package:bettersolver/models/all_post_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/base_constant.dart';
import 'ListofPosts.dart';

class ListOfPostsController extends GetxController {
  var refreshController;
  String? url;
  List islikeboollist = [];
  List isReacting = [];
  List ispostReacted = [];
  List issavepostboollist = [];
  List ispinpostList = [];
  List categoryList = [];
  // List<int> selectedReaction = [];
  List<AudioCl> aud = [];
  // List<Duration?> duration = [];
  // List<bool> curVolume = [];
  // List<bool> isPlaying = [];
  // List<int> curPosition = [];
  List<ReactionType> reactionsURL = [
    ReactionType(
        id: '1',
        url:
            'https://bettersolver.com/demo2/themes/sunshine/reaction/like.gif'),
    ReactionType(
        id: '7',
        url:
            'https://bettersolver.com/demo2/themes/sunshine/reaction/thanks.gif'),
    ReactionType(
        id: '2',
        url:
            'https://bettersolver.com/demo2/themes/sunshine/reaction/love.gif'),
    ReactionType(
        id: '3',
        url:
            'https://bettersolver.com/demo2/themes/sunshine/reaction/haha.gif'),
    ReactionType(
        id: '4',
        url: 'https://bettersolver.com/demo2/themes/sunshine/reaction/wow.gif'),
    ReactionType(
        id: '5',
        url: 'https://bettersolver.com/demo2/themes/sunshine/reaction/sad.gif'),
    ReactionType(
        id: '6',
        url:
            'https://bettersolver.com/demo2/themes/sunshine/reaction/angry.gif'),
  ];

  void onRefresh() async {
    log("onRefresh()");
    await Future.delayed(const Duration(milliseconds: 500));
    fetchallpost("1", url ?? "");
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    log("onLoading()");
    await Future.delayed(const Duration(milliseconds: 500));
    pageno = (int.parse(pageno) + 1).toString();
    await fetchallpost(pageno, url ?? "");
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    // fetchallpost("1", url ?? "");
    fetchCatList();
    super.onInit();
  }

  String pageno = "1";
  bool isLoading = false;
  AllpostBloc? allpostBloc;
  // AllPostModel? allPostModel;
  ScrollController scrollController = ScrollController();
  List posts = [];
  // ApiProvider _provider = ApiProvider();

  // reactPost({required String postID, required String voteID}) async {
  //   EasyLoading.show();
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var userId = pref.getString('userid');
  //   var s = pref.getString('s');
  //   String url =
  //       '${BaseConstant.BASE_URL_DEMO}app_api.php?application=phone&type=voteup';
  //   var params = {
  //     'user_id': userId,
  //     's': s,
  //     'option_id': voteID,
  //     'post_id': postID
  //   };
  //   print(params);
  //   try {
  //     var response = await http.post(
  //       Uri.parse(url),
  //       body: {
  //         'user_id': userId,
  //         's': s,
  //         'option_id': voteID,
  //         'post_id': postID
  //       },
  //     );
  //     var decode = json.decode(response.body);
  //     print(decode);
  //     if (decode['api_status'] == '200') {
  //       // EasyLoading.dismiss();
  //       fetchallpost(pageno, url);
  //     } else {
  //       EasyLoading.showError("Something Went Wrong");
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("Something Went Wrong");
  //   }
  //   update();
  // }

  fetchallpost(String pageno, String url) async {
    if (url != "") {
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
        url,
        // 'demo2/app_api.php?application=phone&type=get_post_all',
        requestBody,
      );
      var data = AllPostModel.fromJson(response);
      if (data.apiStatus == "200") {
        EasyLoading.dismiss();
        if (pageno == '1') {
          posts.clear();
          islikeboollist = [];
          isReacting = [];
          ispostReacted = [];
          issavepostboollist = [];
          ispinpostList = [];
          posts.addAll(data.posts);
        } else {
          posts.addAll(data.posts);
        }
      }
      isLoading = true;
    } else {}
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

  pollVoteUp({required String postID, required String voteID}) async {
    EasyLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userid');
    var s = pref.getString('s');
    String url =
        '${BaseConstant.BASE_URL_DEMO}app_api.php?application=phone&type=voteup';
    var params = {
      'user_id': userId,
      's': s,
      'option_id': voteID,
      // 'post_id': postID
    };
    print(params);
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId,
          's': s,
          'option_id': voteID,
          'post_id': postID
        },
      );
      var decode = json.decode(response.body);
      print(decode);
      if (decode['api_status'] == '200') {
        // EasyLoading.dismiss();
        fetchallpost(
            pageno, 'demo2/app_api.php?application=phone&type=get_post_all');
      } else {
        EasyLoading.showError("Something Went Wrong");
      }
    } catch (e) {
      EasyLoading.showError("Something Went Wrong");
    }
    update();
  }
}
