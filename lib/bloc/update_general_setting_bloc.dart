import 'dart:async';

import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/repository/update_general_setting_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:bettersolver/widgets/popback_dialouge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UpdateGeneralSettingBloc {
  UpdateGeneralSettingRepository? _updateGeneralSettingRepository;
  StreamController? _streamController;

  StreamSink get updategeneralsettingblocDataSink => _streamController!.sink;

  Stream get updategeneralsettingblocDataStream => _streamController!.stream;

  UpdateGeneralSettingBloc(
      String email,
      String number,
      String gender,
      String username,
      String dob,
      String countryid,
      GlobalKey<State> _keyLoader,
      BuildContext context) {
    print('Call Update General Setting ');

    _streamController = StreamController();

    _updateGeneralSettingRepository = UpdateGeneralSettingRepository();

    fetchupdategeneralsettingData(
        email, number, gender, username, dob, countryid, _keyLoader, context);
  }

  fetchupdategeneralsettingData(
      String email,
      String number,
      String gender,
      String username,
      String dob,
      String countryid,
      GlobalKey<State> _keyLoader,
      BuildContext context) async {
    try {
      print('Call Update General Setting - 2 ');

      CommonModel commonModel = await _updateGeneralSettingRepository!
          .fetchgeneralsetting(email, number, gender, username, dob, countryid);

      updategeneralsettingblocDataSink.add(Response.completed(commonModel));

      String? _text = commonModel.apitext;
      String? _status = commonModel.apistatus;
      String? _version = commonModel.apiversion;
      if (_status!.contains('200')) {
        Navigator.pop(context);
        EasyLoading.showSuccess('Data Successfully  Updated');
        // PopBackDialouge.showDialogue(
        //     context, _keyLoader, 'Data Successfully  Updated');
      } else {
        Navigator.pop(context);
        ErrorDialouge.showErrorDialogue(context, _keyLoader,
            commonModel.messages ?? "Error found, Please try again later");
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
