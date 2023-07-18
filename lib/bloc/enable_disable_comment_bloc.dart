import 'dart:async';

import 'package:bettersolver/models/common_message_model.dart';
import 'package:bettersolver/repository/enable_disable_comment_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class EnableDisableCommentBloc {
  EnableDisableCommentRepository? _enableDisableCommentRepository;
  StreamController? _streamController;

  StreamSink
      get enablediasblecommentblocDataSink => _streamController!.sink;

  Stream get enablediasblecommentblocDataStream =>
      _streamController!.stream;

  EnableDisableCommentBloc(String postid, String type,
      GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Enable Disable Comment Bloc');

    _streamController = StreamController<Response<CommonMessageModel>>();
    _enableDisableCommentRepository = EnableDisableCommentRepository();

    fetchenabledisablecommentData(postid, type, _keyLoader, context);
  }

  fetchenabledisablecommentData(String postid, String type,
      GlobalKey<State> _keyLoader, BuildContext context) async {
    try {
      CommonMessageModel commonMessageModel =
          await _enableDisableCommentRepository!.fetchenabledisablecomment(
              postid, type);
      enablediasblecommentblocDataSink
          .add(Response.completed(commonMessageModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
