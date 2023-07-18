import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/join_group_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class JoinGroupBloc {
  JoinGroupRepository? _joinGroupRepository;
  StreamController? _streamController;

  StreamSink get joingroupblocDataSink =>
      _streamController!.sink;

  Stream get joingroupblocDataStream =>
      _streamController!.stream;

  JoinGroupBloc(
      String groupid, GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call join or left group Bloc');

    _streamController = StreamController();
    _joinGroupRepository = JoinGroupRepository();

    fetchjoingroupData(groupid, _keyLoader, context);
  }

  fetchjoingroupData(
      String groupid, GlobalKey<State> _keyLoader, BuildContext context) async {
    try {
      CommonDataModel commonDataModel =
          await _joinGroupRepository!.fetchjoingroup(groupid);
      joingroupblocDataSink.add(Response.completed(commonDataModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
