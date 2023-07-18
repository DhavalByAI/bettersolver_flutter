import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/pinpost_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class PinPostBloc {
  PinPostRepository? _pinPostRepository;
  StreamController? _streamController;

  StreamSink get pinpostblocDataSink =>
      _streamController!.sink;

  Stream get pinpostblocDataStream =>
      _streamController!.stream;

  PinPostBloc(
      String postid, GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Pin Post Bloc');

    _streamController = StreamController();
    _pinPostRepository = PinPostRepository();

    fetchpinpostdata(postid, _keyLoader, context);
  }

  fetchpinpostdata(
      String postid, GlobalKey<State> _keyLoader, BuildContext context) async {
    try {
      CommonDataModel commonDataModel =
          await _pinPostRepository!.fetchpinpost(postid);
      pinpostblocDataSink.add(Response.completed(commonDataModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
