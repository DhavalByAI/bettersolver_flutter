import 'dart:convert';
import 'dart:developer';

import 'package:bettersolver/models/comment_post_model.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:bettersolver/utils/base_constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PostCommentController extends GetxController {
  List<bool> isboollikeList = [];
  List<bool> replyVisible = List.generate(100, (index) => false);
  final ApiProvider _provider = ApiProvider();
  CommentPostModel c = CommentPostModel();
  var commentData;
  List<bool> isReplyEdit = List.generate(50, (index) => false);
  List<bool> isCommentEdit = List.generate(100, (index) => false);

  clearVariable() {
    replyVisible = List.generate(50, (index) => false);
    isReplyEdit = List.generate(50, (index) => false);
    isCommentEdit = List.generate(100, (index) => false);
    commentData = null;
    isboollikeList = [];
  }

  deleteComment({
    required String comment_id,
    required String postid,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userid');
    var s = pref.getString('s');

    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=delete_comment';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId,
          's': s,
          'comment_id': comment_id,
        },
      );
      var res = json.decode(response.body);
      print("cmt : $res");
      if (res['api_status'] == 200) {
        EasyLoading.dismiss();
        getCommentData(postid);
        isReplyEdit = List.generate(50, (index) => false);
      } else {
        EasyLoading.showError("Failed",
            duration: const Duration(milliseconds: 1000),
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("error");
    }
    update();
  }

  deleteCommentReply({
    required String comment_id,
    required String postid,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userid');
    var s = pref.getString('s');

    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=delete_replay_comment';
    var params = {
      'user_id': userId,
      's': s,
      'replay_comment_id': comment_id,
    };
    print(params);
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId,
          's': s,
          'replay_comment_id': comment_id,
        },
      );
      var res = json.decode(response.body);
      print("cmt : ${(response.body)}");
      if (res['api_status'] == 200) {
        EasyLoading.dismiss();
        getCommentData(postid);
        isReplyEdit = List.generate(50, (index) => false);

        // EasyLoading.showSuccess("Commented Successfully",
        //     duration: const Duration(milliseconds: 1000),
        //     maskType: EasyLoadingMaskType.black,
        //     dismissOnTap: true);
      } else {
        EasyLoading.showError("Failed",
            duration: const Duration(milliseconds: 1000),
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("error");
    }
    update();
  }

  EditCommentReply({
    required String comment_id,
    required String text,
    required String postid,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userid');
    var s = pref.getString('s');

    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=edit_replay_comment_post';
    var params = {
      'user_id': userId,
      's': s,
      'edit_replay_comment_id': comment_id,
      'text': text
    };
    print(params);
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId,
          's': s,
          'edit_replay_comment_id': comment_id,
          'text': text
        },
      );
      var res = json.decode(response.body);
      print("cmt : ${(response.body)}");
      if (res['api_status'] == "200") {
        EasyLoading.dismiss();
        getCommentData(postid);
        isReplyEdit = List.generate(50, (index) => false);
        // EasyLoading.showSuccess("Commented Successfully",
        //     duration: const Duration(milliseconds: 1000),
        //     maskType: EasyLoadingMaskType.black,
        //     dismissOnTap: true);
      } else {
        EasyLoading.showError("Failed",
            duration: const Duration(milliseconds: 1000),
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("error");
    }
    update();
  }

  postCommentReply(
      {required String post_id,
      required String comment_id,
      required String text}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userid');
    var s = pref.getString('s');

    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=replay_comment_post';
    var params = {
      'user_id': userId,
      's': s,
      'post_id': post_id,
      'comment_id': comment_id,
      'text': text
    };
    print(params);
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId,
          's': s,
          'post_id': post_id,
          'comment_id': comment_id,
          'text': text
        },
      );
      var res = json.decode(response.body);
      print("cmt : ${(response.body)}");
      if (res['status'] == 200) {
        EasyLoading.dismiss();

        getCommentData(post_id);
        // EasyLoading.showSuccess("Commented Successfully",
        //     duration: const Duration(milliseconds: 1000),
        //     maskType: EasyLoadingMaskType.black,
        //     dismissOnTap: true);
      } else {
        EasyLoading.showError("Failed",
            duration: const Duration(milliseconds: 1000),
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("error");
    }
    update();
  }

  CommentPost({
    required String postid,
    required String commenttext,
    String? commentId,
    bool? isEdit = false,
  }) async {
    EasyLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    // try {
    final requestBody = (isEdit!)
        ? {
            "user_id": userid,
            "s": s,
            "post_id": postid,
            "text": commenttext,
            "hash": 'fcab40bcb97a6638f86a',
            "page_id": '0',
            "audio": '',
            'comment_id': commentId
          }
        : {
            "user_id": userid,
            "s": s,
            "post_id": postid,
            "text": commenttext,
            "hash": 'fcab40bcb97a6638f86a',
            "page_id": '0',
            "audio": '',
          };
    print(requestBody);
    final response = await _provider.httpMethodWithoutToken(
      'post',
      'demo2/app_api.php?application=phone&type=comment_post',
      requestBody,
    );

    c = CommentPostModel.fromJson(response);

    (c.apiStatus == 200 || c.status == 200)
        ? getCommentData(postid)
        : EasyLoading.showError("Failed");
    isCommentEdit = List.generate(100, (index) => false);
    EasyLoading.dismiss();
    // } catch (e) {
    //   EasyLoading.showError("Failed");
    // }
    update();
  }

  getCommentData(
    String postid,
  ) async {
    EasyLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=get_post_data';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userid,
          's': s,
          'post_id': postid,
        },
      );
      var res = json.decode(response.body);
      commentData = res['post_data'];
      log("Comment fatched");
      print(commentData);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError("Failed");
    }
    update();
  }

  reportComment(String commentId, String postID) async {
    EasyLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=report_comment';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userid,
          's': s,
          'comment_id': commentId,
        },
      );
      var res = json.decode(response.body);
      // commentData = res['post_data'];
      // log("Comment fatched");
      print(res);
      await getCommentData(postID);
      EasyLoading.showSuccess(res['data']);
    } catch (e) {
      EasyLoading.showError("Failed");
    }
    update();
  }
}
