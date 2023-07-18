import 'dart:async';

import 'package:bettersolver/models/blocked_list_model.dart';
import 'package:bettersolver/repository/blocked_list_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class BlockedListBloc {
  BlockedListRepository? _blockedListRepository;
  StreamController? _streamController;

  StreamSink get blockedlistblocDataSink =>
      _streamController!.sink;

  Stream get blockedlistblocStream =>
      _streamController!.stream;

  BlockedListBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Blocked List bloc');

    _streamController = StreamController();
    _blockedListRepository = BlockedListRepository();

    fetchBlockedListData(_keyLoader, context);
  }

  fetchBlockedListData(
      GlobalKey<State> _keyLoader, BuildContext context) async {
    blockedlistblocDataSink.add(Response.loading('Loading...'));

    try {
      BlockedListModel blockedListModel =
          await _blockedListRepository!.fetchBlockedList();
      blockedlistblocDataSink.add(Response.completed(blockedListModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
