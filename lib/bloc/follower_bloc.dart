import 'dart:async';

import 'package:bettersolver/models/follower_model.dart';
import 'package:bettersolver/repository/Follower_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class FollowerBloc {
  FollowerRepository? _followerRepository;
  StreamController? _streamController;

  StreamSink get followerblocDataSink =>
      _streamController!.sink;

  Stream get followerblocDataStream =>
      _streamController!.stream;

  FollowerBloc(String uid, GlobalKey<State> _keyLoader, BuildContext context) {
    print('call Follower  bloc');

    _streamController = StreamController();
    _followerRepository = FollowerRepository();

    fetchFollowerData(uid, _keyLoader, context);
  }

  fetchFollowerData(
      String _uid, GlobalKey<State> _keyLoader, BuildContext context) async {
    followerblocDataSink.add(Response.loading('Loading...'));
    print('call Follower inside bloc');

    try {
      print('call Follower inside 1 bloc');

      FollowerModel followerModel =
          await _followerRepository!.fetchFollowerData(_uid);
      followerblocDataSink.add(Response.completed(followerModel));
      //

    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
