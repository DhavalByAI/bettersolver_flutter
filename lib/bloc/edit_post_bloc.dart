import 'dart:async';
import 'dart:developer';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/edit_post_repository.dart';
import 'package:bettersolver/screen/home_screen_controller.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditPostBloc {
  EditPostRepository? editPostRepository;
  StreamController? _streamController;

  StreamSink get editPostBlocDataSink => _streamController!.sink;

  Stream get editPostBlocDataStram => _streamController!.stream;

  EditPostBloc(String postid, String text, String group_id, String title,
      GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Blocked Bloc');
    _streamController = StreamController();
    editPostRepository = EditPostRepository();

    fetchEditPost(postid, text, group_id, title, _keyLoader, context);
  }

  fetchEditPost(String postid, String text, String group_id, String title,
      GlobalKey<State> _keyLoader, BuildContext context) async {
    try {
      CommonDataModel commonDataModel =
          await editPostRepository!.editPost(postid, text, group_id, title);
      editPostBlocDataSink.add(Response.completed(commonDataModel));
      Navigator.pop(context);
      var api_status = commonDataModel.apiText;

      if (api_status == 'success') {
        EasyLoading.showSuccess("Post Updated Successfully");
        log("post updated successfully !!");

        // Navigator.pop(context);
        // Navigator.pop(context);
        // ErrorDialouge.showErrorDialogue(
        //     context, _keyLoader, 'Post updated successfully....');
      } else {
        EasyLoading.showError("Something Went Wring !!");
        // Navigator.pop(context);
        // Navigator.pop(context);
        // ErrorDialouge.showErrorDialogue(
        //     context, _keyLoader, "Post is not updated....");
      }
    } catch (e) {
      Navigator.pop(context);
      EasyLoading.dismiss();
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
