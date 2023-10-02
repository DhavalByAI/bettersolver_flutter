import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/famoususer_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:flutter/cupertino.dart';

class FamousUserBloc {
  FamousUserRepository? _famousUserRepository;
  StreamController? _streamController;

  StreamSink get FamousUserBlocDataSink => _streamController!.sink;

  Stream get FamousUserBlocDataStream => _streamController!.stream;

  FamousUserBloc(String userid, String s, GlobalKey<State> _keyLoader,
      BuildContext context) {
    print('Famous User Login');
    _streamController = StreamController.broadcast();
    _famousUserRepository = FamousUserRepository();

    fetchFamousUserData(userid, s, _keyLoader, context);
  }

  fetchFamousUserData(String userid, String s, GlobalKey<State> keyLoader,
      BuildContext context) async {
    FamousUserBlocDataSink.add(Response.loading('Loading......'));

    try {
      print('Famous User Login-------------');

      CommonDataModel commonData =
          await _famousUserRepository!.fetchFamousUser(userid, s);
      FamousUserBlocDataSink.add(Response.completed(commonData));
    } catch (e) {
      FamousUserBlocDataSink.add(Response.error(e.toString()));
      print("Exception === $e");
    }
  }
}
