import 'dart:async';

import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/repository/change_password_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ChangePasswordBloc {
  ChangePasswordRepository? _changePasswordRepository;
  StreamController? _streamController;

  StreamSink get changepasswordblocDataSink => _streamController!.sink;

  Stream get changepasswordblocDataStream => _streamController!.stream;

  ChangePasswordBloc(String currentpass, String newpass, String repetpass,
      GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Change Password Bloc');

    _streamController = StreamController();
    _changePasswordRepository = ChangePasswordRepository();

    fetchChangepasswordData(
        currentpass, newpass, repetpass, _keyLoader, context);
  }

  fetchChangepasswordData(String currentpass, String newpass, String repetpass,
      GlobalKey<State> _keyLoader, BuildContext context) async {
    changepasswordblocDataSink.add(Response.loading('Loading...'));
    try {
      CommonModel commonModel = await _changePasswordRepository!
          .fetchchangepasssword(currentpass, newpass, repetpass);
      changepasswordblocDataSink.add(Response.completed(commonModel));

      String? _text = commonModel.apitext;
      String? _status = commonModel.apistatus;
      String? _version = commonModel.apiversion;

      if (_status!.contains("200")) {
        EasyLoading.showSuccess("password change successfully");

        // ErrorDialouge.showErrorDialogue(
        //     context, _keyLoader, "password change successfully");
      } else {
        ErrorDialouge.showErrorDialogue(
            context, _keyLoader, 'Current password not match');
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
