import 'dart:async';

import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/repository/viewprofile_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:flutter/cupertino.dart';

class ViewProfileBloc {
  ViewProfileRepository? _viewProfileRepository;
  StreamController? _streamController;

  StreamSink get viewProfileblocDataSink => _streamController!.sink;

  Stream get viewProfileblocDataStream => _streamController!.stream;

  ViewProfileBloc(
      String viewuserid, GlobalKey<State> _keyLoader, BuildContext context) {
    print('call View Profile detail bloc');

    _streamController = StreamController();
    _viewProfileRepository = ViewProfileRepository();

    fetchViewProfileData(viewuserid, _keyLoader, context);
  }

  fetchViewProfileData(String viewuserid, GlobalKey<State>? _keyLoader,
      BuildContext? context) async {
    viewProfileblocDataSink.add(Response.loading('Loading..'));

    try {
      UserDetailModel userDetailModel =
          await _viewProfileRepository!.fetchViewUserDetail(viewuserid);
      viewProfileblocDataSink.add(Response.completed(userDetailModel));
    } catch (e) {}
  }
}
