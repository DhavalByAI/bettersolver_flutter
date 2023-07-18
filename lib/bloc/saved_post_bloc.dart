import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/saved_post_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class SavepostBloc {
  SavedPostRepository? _savedPostRepository;
  StreamController? _streamController;

  StreamSink get savepostblocDatasink =>
      _streamController!.sink;

  Stream get savepostblocDataStream =>
      _streamController!.stream;

  SavepostBloc(
      String postid, GlobalKey<State> _keyLoader, BuildContext context) {
    print('call SAVE POST BLoc');

    _streamController = StreamController();
    _savedPostRepository = SavedPostRepository();
    fetchsavepost(postid, _keyLoader, context);
  }

  fetchsavepost(
      String postid, GlobalKey<State> _keyLoader, BuildContext context) async {
    savepostblocDatasink.add(Response.loading('Loading....'));

    try {
      CommonDataModel commonDataModel =
          await _savedPostRepository!.fetchSavedPost(postid);
      savepostblocDatasink.add(Response.completed(commonDataModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
