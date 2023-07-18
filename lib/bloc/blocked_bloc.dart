import 'dart:async';

import 'package:bettersolver/models/blocked_model.dart';
import 'package:bettersolver/repository/blocked_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BlockedBloc {
  BlockedRepository? _blockedRepository;
  StreamController? _streamController;

  StreamSink get blockedblocDataSink => _streamController!.sink;

  Stream get blockedblocDataStram => _streamController!.stream;

  BlockedBloc(String blockeduserid, String type, GlobalKey<State> _keyLoader,
      BuildContext context, String msg) {
    print('Call Blocked Bloc');

    _streamController = StreamController();
    _blockedRepository = BlockedRepository();

    fetchBlockedData(blockeduserid, type, _keyLoader, context, msg);
  }

  fetchBlockedData(String blockeduserid, String type,
      GlobalKey<State> _keyLoader, BuildContext context, String msg) async {
    blockedblocDataSink.add(Response.loading('Loading...'));

    try {
      BlockedModel blockedModel =
          await _blockedRepository!.fetchBlocked(blockeduserid, type);
      blockedblocDataSink.add(Response.completed(blockedModel));

      Navigator.pop(context);
      EasyLoading.showSuccess(msg);
      // ErrorDialouge.showErrorDialogue(context, _keyLoader, "User Un-Blocked");
    } catch (e) {
      Navigator.pop(context);

      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
