import 'dart:async';

import 'package:bettersolver/models/my_activities_model.dart';
import 'package:bettersolver/repository/my_activities_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class MyActivitesBloc {
  MyActivitiesRepository? _myActivitiesRepository;
  StreamController? _streamController;

  StreamSink get myactivitiesblocDataSink =>
      _streamController!.sink;

  Stream get myactivitiesblocDataStream =>
      _streamController!.stream;

  MyActivitesBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('call My Activities Bloc');

    _streamController = StreamController();
    _myActivitiesRepository = MyActivitiesRepository();

    fetchMyactivitiesData(_keyLoader, context);
  }

  fetchMyactivitiesData(
      GlobalKey<State> _keyLoader, BuildContext context) async {
    myactivitiesblocDataSink.add(Response.loading('Loading..'));

    try {
      MyActivitesModel activitesModel =
          await _myActivitiesRepository!.fetchmtactivities();
      myactivitiesblocDataSink.add(Response.completed(activitesModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
