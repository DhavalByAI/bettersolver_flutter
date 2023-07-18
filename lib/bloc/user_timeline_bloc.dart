import 'dart:async';

import 'package:bettersolver/models/user_timeline_model.dart';
import 'package:bettersolver/repository/user_timeline_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class UserTimeLineBloc {
  UserTimelineRepository? _userTimelineRepository;
  StreamController? _streamController;

  StreamSink get usertimelineBlocDataSink =>
      _streamController!.sink;

  Stream get usertimelineBlocDataStream =>
      _streamController!.stream;

  UserTimeLineBloc(String pageno, String viewid, GlobalKey<State> _keyLoader,
      BuildContext context) {
    print('Call USER TIME Line Bloc');

    _streamController = StreamController();
    _userTimelineRepository = UserTimelineRepository();

    fetchusertimelineData(pageno, viewid, _keyLoader, context);
  }

  fetchusertimelineData(String pageno, String viewid,
      GlobalKey<State> _keyLoader, BuildContext context) async {
    usertimelineBlocDataSink.add(Response.loading('Loading...'));
    try {
      UserTimeLineModel userTimeLineModel =
          await _userTimelineRepository!.fetchUsertimeline(pageno, viewid);
      usertimelineBlocDataSink.add(Response.completed(userTimeLineModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }

}
