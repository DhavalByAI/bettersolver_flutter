import 'dart:async';

import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/repository/userdetail_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class UserDetailBloc {
  UserDetailRepository? _userDetailRepository;
  StreamController? _streamController;

  StreamSink get userdetailblocDataSink =>
      _streamController!.sink;

  Stream get userdetailblocDataStream =>
      _streamController!.stream;

  UserDetailBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('call user detail bloc');

    _streamController = StreamController();
    _userDetailRepository = UserDetailRepository();

    fetchUserDetailData(_keyLoader, context);
  }

  fetchUserDetailData(GlobalKey<State> _keyLoader, BuildContext context) async {
    userdetailblocDataSink.add(Response.loading('Loading..'));
    try {
      UserDetailModel userDetailModel =
          await _userDetailRepository!.fetchUserDetail();
      userdetailblocDataSink.add(Response.completed(userDetailModel));
    } catch (e) {
      // Navigator.pop(context);
      // ErrorDialouge.showErrorDialogue(
      //     context, _keyLoader, "Something went wrong, Contact Admin..!");
      // print("Exception === $e");
    }
  }

  dispose() {
    _streamController!.close();
  }
}
