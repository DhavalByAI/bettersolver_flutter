import 'dart:async';

import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/repository/sociallinks_update_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SocialLinksUpdateBloc {
  SocialLinksUpdateRepository? _socialLinksUpdateRepository;
  StreamController? _streamController;

  StreamSink get sociallinksupdateblocDataSink => _streamController!.sink;

  Stream get sociallinksupdateblocDataStream => _streamController!.stream;

  SocialLinksUpdateBloc(
      String facebook,
      String twitter,
      String youtube,
      String linkedin,
      String instagram,
      GlobalKey<State> _keyLoader,
      BuildContext context) {
    print('call Social Link update bloc');

    _streamController = StreamController();
    _socialLinksUpdateRepository = SocialLinksUpdateRepository();

    fetchSociallinksupdateData(
        facebook, twitter, youtube, linkedin, instagram, _keyLoader, context);
  }

  fetchSociallinksupdateData(
      String facebook,
      String twitter,
      String youtube,
      String linkedin,
      String instagram,
      GlobalKey<State> _keyLoader,
      BuildContext context) async {
    sociallinksupdateblocDataSink.add((Response.loading('Loading...')));

    try {
      CommonModel commonModel = await _socialLinksUpdateRepository!
          .fetchsociallinksupdate(
              facebook, twitter, youtube, linkedin, instagram);
      sociallinksupdateblocDataSink.add(Response.completed(commonModel));

      String? _status = commonModel.apistatus;

      if (_status!.contains("200")) {
        Navigator.pop(context);
        EasyLoading.showSuccess("Social Links updated");
        // ErrorDialouge.showErrorDialogue(
        //     context, _keyLoader, "Social Links updated");
      } else {
        ErrorDialouge.showErrorDialogue(
            context, _keyLoader, "Something went wrong, Contact Admin..!");
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
