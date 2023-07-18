import 'dart:async';

import 'package:bettersolver/models/privacy_get_model.dart';
import 'package:bettersolver/repository/privacy_get_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class PrivacyGetBloc {
  PrivacyGetRepository? _privacyGetRepository;
  StreamController? _streamController;

  StreamSink get privacygetblocDataSink =>
      _streamController!.sink;

  Stream get privacygetblocDataStream =>
      _streamController!.stream;

  PrivacyGetBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Privacy get Bloc');

    _streamController = StreamController();
    _privacyGetRepository = PrivacyGetRepository();

    fetchPrivacyGetData(_keyLoader, context);
  }

  fetchPrivacyGetData(GlobalKey<State> _keyLoader, BuildContext context) async {
    privacygetblocDataSink.add(Response.loading('Loading..'));

    try {
      PrivacyGetModel privacyGetModel =
          await _privacyGetRepository!.fetchprivacy();
      privacygetblocDataSink.add(Response.completed(privacyGetModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
