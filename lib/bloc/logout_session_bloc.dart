import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/logout_session_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'mange_session_list_bloc.dart';

class LogoutSessionBloc {
  LogoutSessionRepository? _logoutSessionRepository;
  StreamController? _streamController;

  StreamSink get logoutsessionblocDataSink => _streamController!.sink;

  Stream get logoutsessionblocDataStream => _streamController!.stream;

  LogoutSessionBloc(String type, String sessionid, GlobalKey<State> _keyLoader,
      BuildContext context) {
    print('calling  Bloc Logout');

    _streamController = StreamController();
    _logoutSessionRepository = LogoutSessionRepository();

    fetchLogoutSessionData(type, sessionid, _keyLoader, context);
  }

  fetchLogoutSessionData(String type, String sessionid,
      GlobalKey<State> _keyLoader, BuildContext context) async {
    logoutsessionblocDataSink.add(Response.loading('Loading....'));

    try {
      CommonDataModel commonDataModel =
          await _logoutSessionRepository!.fetchlogoutsession(type, sessionid);
      logoutsessionblocDataSink.add(Response.completed(commonDataModel));

      String? _text = commonDataModel.apiText;
      String? _status = commonDataModel.apiStatus;
      String? _version = commonDataModel.apiVersion;
      String? _data = commonDataModel.data;

      if (_status!.contains("200")) {
        EasyLoading.showSuccess(_data!);
        // ErrorDialouge.showErrorDialogue(context, _keyLoader, _data!);
      } else {
        ErrorDialouge.showErrorDialogue(context, _keyLoader, _data!);
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
