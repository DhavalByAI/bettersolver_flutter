import 'dart:async';

import 'package:bettersolver/bottom_navigation.dart';
import 'package:bettersolver/models/loginmodel.dart';
import 'package:bettersolver/repository/loginrepository.dart';
import 'package:bettersolver/screen/auth/login.dart';
import 'package:bettersolver/utils/base_constant.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  LoginRepository? _loginRepository;
  StreamController? _streamController;

  StreamSink get LoginBlocDataSink => _streamController!.sink;

  Stream get LoginBlocDataStream => _streamController!.stream;

  LoginBloc(String type, String username, String password, String s,
      GlobalKey<State> _keyLoader, BuildContext context, var fcmToken) {
    print("call==== loginBLOC");
    _streamController = StreamController();
    _loginRepository = LoginRepository();
    fetchLoginData(type, username, password, s, _keyLoader, context, fcmToken);
  }

  fetchLoginData(String type, String username, String password, String s,
      GlobalKey<State> _keyLoader, BuildContext context, var fcmToken) async {
    //loginDataSink.add(Response.loading('Authenticating login'));
    // try {
    print("call==== loginBLOC2");

    LoginModel loginData = await _loginRepository!
        .fetchLogin(type, username, password, s, fcmToken);
    LoginBlocDataSink.add(Response.completed(loginData));
    // Navigator.pop(context);
    String? _text = loginData.apiText;
    String? _status = loginData.apiStatus;
    String? _version = loginData.apiVersion;

    // String _message = loginData.message;
    print("call==== loginBLOC3 $_status");

    if (_status == "200") {
      print("call==== loginBLOC4");
      String? _userid = loginData.userId;
      String? _profileimg = loginData.profileImage;
      String imgurl = BaseConstant.BASE_URL_DEMO + (_profileimg ?? "");

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('userid', _userid!);
      pref.setString('profileimage', imgurl);
      pref.setBool('login', true);

      pref.setString('s', s);
      print('session ---- $s');

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => Home(),
        ),
      );
    } else {
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (_) => Login()), (route) => false);
      EasyLoading.showError('${loginData.errors['error_text']}');
    }
    // } catch (e) {
    //   Navigator.pushAndRemoveUntil(context,
    //       MaterialPageRoute(builder: (_) => Login()), (route) => false);
    //   EasyLoading.showError('Error found, please try again later.');
    //   print("Exception === $e");
    // }
  }
}
