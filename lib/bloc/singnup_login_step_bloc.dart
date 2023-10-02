import 'dart:async';
import 'dart:math';

import 'package:bettersolver/models/loginmodel.dart';
import 'package:bettersolver/repository/loginrepository.dart';
import 'package:bettersolver/screen/auth/register_first_step.dart';
import 'package:bettersolver/utils/response.dart' as r;
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signupLoginBloc {
  LoginRepository? _loginRepository;
  StreamController? _streamController;

  StreamSink get LoginBlocDataSink => _streamController!.sink;

  Stream get LoginBlocDataStream => _streamController!.stream;

  signupLoginBloc(
      String type,
      String email,
      String fname,
      String password,
      String byear,
      String bmonth,
      String bday,
      GlobalKey<State> keyLoader,
      BuildContext context,
      String date,
      fcmToken) {
    print("call==== login-signup-BLOC");
    _streamController = StreamController();
    _loginRepository = LoginRepository();
    fetchLoginSignupData(type, email, fname, password, byear, bmonth, bday,
        keyLoader, context, date, fcmToken);
  }

  fetchLoginSignupData(
      String type,
      String email,
      String fname,
      String password,
      String byear,
      String bmonth,
      String bday,
      GlobalKey<State> keyLoader,
      BuildContext context,
      String date,
      var fcmToken) async {
    //loginDataSink.add(Response.loading('Authenticating login'));
    try {
      print("call==== login-signupBLOC2");
      int s = 0;

      var random = Random();
      s = random.nextInt(100000);

      LoginModel loginData = await _loginRepository!
          .fetchLogin(type, email, password, s.toString(), fcmToken);
      LoginBlocDataSink.add(r.Response.completed(loginData));
      //Navigator.pop(context);
      String? text = loginData.apiText;
      String? status = loginData.apiStatus;
      String? version = loginData.apiVersion;
      String? userid = loginData.userId;
      String? profileimg = loginData.profileImage;

      // String _message = loginData.message;
      print("call==== login-signupBLOC3 $status");
      print("session id from signup Loginip login   $s");

      if (status!.contains("200")) {
        print("call==== login-signup4");

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userid', userid!);
        pref.setString('s', s.toString());

        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (_) => RegisterFirstScreen(
        //       date: date,
        //       email: email,
        //       fname: fname,
        //     ),
        //   ),
        // );
        //  Get.offAll(Login());
        Get.offAll(() => RegisterFirstScreen(
              date: date,
              email: email,
              fname: fname,
            ));
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (_) => RegisterFirstScreen(
        //       date: date,
        //       email: email,
        //       fname: fname,
        //     ),
        //   ),
        // );
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
