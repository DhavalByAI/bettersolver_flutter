import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/models/home_comment_list_model.dart';
import 'package:bettersolver/repository/home_comment_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class HomeCommentListBloc {
  HomeCommentRepository? homeCommentRepository;
  StreamController? _streamController;

  StreamSink get homeCommentBlocDataSink =>
      _streamController!.sink;

  Stream get homeCommentBlocDataStream =>
      _streamController!.stream;

  HomeCommentListBloc(String postid,
      GlobalKey<State> _keyLoader, BuildContext context) {

    _streamController = StreamController();
    homeCommentRepository = HomeCommentRepository();

    fetchcommentpostdata(postid, _keyLoader, context);
  }

  fetchcommentpostdata(String postid,
      GlobalKey<State> _keyLoader, BuildContext context) async {
    homeCommentBlocDataSink.add(Response.loading('Loading....'));
    try {
      HomeCommentListModel commentPostModel =
      await homeCommentRepository!.fetchHomeComment(postid);
      homeCommentBlocDataSink.add(Response.completed(commentPostModel));

    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}