import 'dart:async';

import 'package:bettersolver/models/comment_post_model.dart';
import 'package:bettersolver/repository/comment_post_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:bettersolver/widgets/popback_dialouge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CommentPostBloc {
  CommentPostRepository? _commentPostRepository;
  StreamController? _streamController;

  StreamSink get commentpostblocDataSink => _streamController!.sink;

  Stream get commentpostblocDataStream => _streamController!.stream;

  CommentPostBloc(String postid, String commentText,
      GlobalKey<State> _keyLoader, BuildContext context,
      {required Function() onSuccess}) {
    print('Call Comment Post bloc');

    _streamController = StreamController();
    _commentPostRepository = CommentPostRepository();

    fetchcommentpostdata(postid, commentText, _keyLoader, context,
        onSuccess: onSuccess);
  }

  fetchcommentpostdata(String postid, String commentText,
      GlobalKey<State> _keyLoader, BuildContext context,
      {required Function() onSuccess}) async {
    // commentpostblocDataSink.add(Response.loading('Loading....'));
    print('Call Comment Post bloc  2');

    try {
      print('Call Comment Post bloc  3');

      CommentPostModel commentPostModel =
          await _commentPostRepository!.fetchCommentPost(postid, commentText);
      commentpostblocDataSink.add(Response.completed(commentPostModel));
      Navigator.pop(context);
      int? _text = commentPostModel.apiStatus;

      if (_text == 200) {
        onSuccess();
        EasyLoading.showSuccess("Data Updated");

        // Navigator.pop(context);
//        PopBackDialouge.showDialogue(context, _keyLoader, 'Data Updated');
      } else {
        ErrorDialouge.showErrorDialogue(
            context, _keyLoader, 'Error found, please try again later.');
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
