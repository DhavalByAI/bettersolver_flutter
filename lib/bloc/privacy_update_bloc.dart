import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/privacy_update_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:bettersolver/widgets/popback_dialouge.dart';
import 'package:flutter/cupertino.dart';

class PrivacyUpdateBloc {
  PrivacyUpdateRepository? _privacyUpdateRepository;
  StreamController? _streamController;

  StreamSink get privacyupdateblocDataSink =>
      _streamController!.sink;

  Stream get privacyupdateblocDataStream =>
      _streamController!.stream;

  PrivacyUpdateBloc(
      String followMe,
      String messagewMe,
      String myFollowers,
      String myTimeline,
      String mydob,
      String visitProfile,
      String myactivities,
      String myStatus,
      String livePublic,
      String search,
      GlobalKey<State> _keyLoader,
      BuildContext context) {
    print('call Update Privacy Bloc');

    _streamController = StreamController();
    _privacyUpdateRepository = PrivacyUpdateRepository();

    fetchprivacyupdateData(
        followMe,
        messagewMe,
        myFollowers,
        myTimeline,
        mydob,
        visitProfile,
        myactivities,
        myStatus,
        livePublic,
        search,
        _keyLoader,
        context);
  }

  fetchprivacyupdateData(
      String followMe,
      String messagewMe,
      String myFollowers,
      String myTimeline,
      String mydob,
      String visitProfile,
      String myactivities,
      String myStatus,
      String livePublic,
      String search,
      GlobalKey<State> keyLoader,
      BuildContext context) async {
    privacyupdateblocDataSink.add(Response.loading('Loading...'));
    try {
      CommonDataModel commonDataModel =
          await _privacyUpdateRepository!.fetchprivacy(
              followMe,
              messagewMe,
              myFollowers,
              myTimeline,
              mydob,
              visitProfile,
              myactivities,
              myStatus,
              livePublic,
              search);
      privacyupdateblocDataSink.add(Response.completed(commonDataModel));

      String data = commonDataModel.data;

      Navigator.pop(context);

      PopBackDialouge.showDialogue(context, keyLoader, data);
    } catch (e) {
      Navigator.pop(context);
      // ErrorDialouge.showErrorDialogue(
      //     context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
