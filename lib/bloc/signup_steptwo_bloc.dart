import 'dart:async';

import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/repository/signup_steptwo_repository.dart';
import 'package:bettersolver/screen/auth/register_thired_step.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupStepTwoBloc {
  SignupStepTwoRepository? _signupStepTwoRepository;
  StreamController? _streamController;

  StreamSink get SignupStepTwoBlocDataSink => _streamController!.sink;

  Stream get SignupStepTwoBlocDataStream => _streamController!.stream;

  SignupStepTwoBloc(
      String type,
      String userid,
      String s,
      String username,
      String dob,
      String countryid,
      String occupation,
      String fname,
      GlobalKey<State> _keyLoader,
      BuildContext context) {
    print('calling--------- SignupStepTwoBloc');

    _streamController = StreamController();
    _signupStepTwoRepository = SignupStepTwoRepository();

    fetchSignupStepTwoData(type, userid, s, username, dob, countryid,
        occupation, fname, _keyLoader, context);
  }

  fetchSignupStepTwoData(
      String type,
      String userid,
      String s,
      String username,
      String dob,
      String countryid,
      String occupation,
      String fname,
      GlobalKey<State> keyLoader,
      BuildContext context) async {
    try {
      CommonModel commonData = await _signupStepTwoRepository!
          .fetchSignupsteptwo(
              type, userid, s, username, dob, countryid, occupation, fname);

      SignupStepTwoBlocDataSink.add(Response.completed(commonData));

      String? text = commonData.apitext;
      String? status = commonData.apistatus;
      String? version = commonData.apiversion;

      print('ststus ===$status');

      if (status!.contains("200")) {
        print('---------bloc ----------call');
        //   Navigator.pop(context);

        SharedPreferences pref = await SharedPreferences.getInstance();
        String? userid0 = pref.getString("userid");
        String? sid = pref.getString("s");
        // Navigator.push(context,
        //    MaterialPageRoute(builder: (context) => RegisterThiredScreen(
        //
        //      uid: _userid,
        //      sid: _sid,
        //
        //    )));

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => RegisterThiredScreen(
              uid: userid0,
              sid: sid,
            ),
          ),
        );
      } else {
        ErrorDialouge.showErrorDialogue(context, keyLoader,
            'Error found, please try again later Or Enter Valid Username');
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
