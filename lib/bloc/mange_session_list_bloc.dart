import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/manage_session_list_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class ManageSessionListBloc {
  ManageSessionListRepository? _manageSessionListRepository;
  StreamController? _streamController;

  StreamSink get mangesessionlistblocDataSink =>
      _streamController!.sink;

  Stream get mangesessionlistblocDataStream =>
      _streamController!.stream;

  ManageSessionListBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('calling session List Bloc');

    _streamController = StreamController();
    _manageSessionListRepository = ManageSessionListRepository();

    fetchMAngesessionListData(_keyLoader, context);
  }

  fetchMAngesessionListData(
      GlobalKey<State> _keyLoader, BuildContext context) async {
    mangesessionlistblocDataSink.add(Response.loading('Loading...'));

    try {
      CommonDataModel commonDataModel =
          await _manageSessionListRepository!.fetchMangeSessionList();
      mangesessionlistblocDataSink.add(Response.completed(commonDataModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
