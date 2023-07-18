import 'dart:async';

import 'package:bettersolver/models/following_models.dart';
import 'package:bettersolver/repository/following_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class FollowingBloc {
  FollowingRepository? _followingRepository;
  StreamController? _streamController;

  StreamSink get followingblocDataSink =>
      _streamController!.sink;

  Stream get followingblocDataStream =>
      _streamController!.stream;

  FollowingBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('call Following  bloc');

    _streamController = StreamController();
    _followingRepository = FollowingRepository();

    fetchFollowingData(_keyLoader, context);
  }

  fetchFollowingData(GlobalKey<State> _keyLoader, BuildContext context) async {
    followingblocDataSink.add(Response.loading('Loading...'));

    try {
      FollowingModel followingModel =
          await _followingRepository!.fetchFollowingData();
      followingblocDataSink.add(Response.completed(followingModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
