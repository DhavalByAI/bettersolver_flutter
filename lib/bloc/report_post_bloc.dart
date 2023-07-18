import 'dart:async';

import 'package:bettersolver/models/common_data_integer_model.dart';
import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/report_post_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class ReportPostBloc {
  ReportPostRepository? _reportPostRepository;
  StreamController? _streamController;

  StreamSink get reportpostblocDataSink =>
      _streamController!.sink;

  Stream get reportpostblocDataStream =>
      _streamController!.stream;

  ReportPostBloc(String postid, String text, GlobalKey<State> _keyLoader,
      BuildContext context) {
    print('Call Report post Bloc');

    _streamController = StreamController();
    _reportPostRepository = ReportPostRepository();

    fetchreportpostData(postid, text, _keyLoader, context);
  }

  fetchreportpostData(String postid, String text, GlobalKey<State> _keyLoader,
      BuildContext context) async {
    try {
      CommonDataIntegerModel commonDataModel =
          await _reportPostRepository!.fetchReportpost(postid, text);
      reportpostblocDataSink.add(Response.completed(commonDataModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
