import 'dart:async';

import 'package:bettersolver/models/common_data_integer_model.dart';
import 'package:bettersolver/repository/hide_post_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class HidePostBloc {
  HidePostRepository? _hidePostRepository;
  StreamController? _streamController;

  StreamSink get hidepostblocDataSink =>
      _streamController!.sink;

  Stream get hidepostblocDataStream =>
      _streamController!.stream;

  HidePostBloc(
      String postid, GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Hide Post Bloc');

    _streamController = StreamController();
    _hidePostRepository = HidePostRepository();

    fetchHidePostData(postid, _keyLoader, context);
  }

  fetchHidePostData(String postid, GlobalKey<State> _keyLoader, BuildContext context) async {
    try {
      CommonDataIntegerModel commonDataIntegerModel =
          await _hidePostRepository!.fetchhidepost(postid);
      hidepostblocDataSink.add(Response.completed(commonDataIntegerModel));
      Navigator.pop(context);

      int? _status = commonDataIntegerModel.apiStatus;

      if (_status == 200) {
        print('hide success::::::::::');
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
