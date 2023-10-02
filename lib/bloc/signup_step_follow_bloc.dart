import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/signup_stepthree_follow_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class SignupStepFollowBloc {
  SignupStepFollowRepository? _signupStepFollowRepository;
  StreamController? _streamController;

  StreamSink get signupStepFollowBlocDataSink => _streamController!.sink;

  Stream get signupStepFollowBlocDataStream => _streamController!.stream;

  SignupStepFollowBloc(String userid, String s, String recipientid,
      GlobalKey<State> _keyLoader, BuildContext context) {
    _streamController = StreamController();
    _signupStepFollowRepository = SignupStepFollowRepository();

    fetchSignupStepFollowData(userid, s, recipientid, _keyLoader, context);
  }

  fetchSignupStepFollowData(String userid, String s, String recipientid,
      GlobalKey<State> keyLoader, BuildContext context) async {
    try {
      CommonDataModel commonDataModel = await _signupStepFollowRepository!
          .fetchFolloweduser(userid, s, recipientid);

      signupStepFollowBlocDataSink.add(Response.completed(commonDataModel));

      String? text = commonDataModel.apiText;
      String? status = commonDataModel.apiStatus;
      String? version = commonDataModel.apiVersion;

      print('Status ------ $status');

      if (status!.contains("200")) {
        // Navigator.pop(context);
      } else {
        ErrorDialouge.showErrorDialogue(
            context, keyLoader, 'Error found, please try again later.');
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
