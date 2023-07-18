import 'dart:async';
import 'package:bettersolver/bloc/singnup_login_step_bloc.dart';
import 'package:bettersolver/models/signupmodel.dart';
import 'package:bettersolver/repository/signuprepository.dart';
import 'package:bettersolver/screen/auth/register_first_step.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupBloc {
  SignupRepository? _signupRepository;
  StreamController? _streamController;

  StreamSink get SignupBlocDataSink =>
      _streamController!.sink;

  Stream get SignupBlocDatStream =>
      _streamController!.stream;

  SignupBloc(
      String email,
      String fname,
      String lname,
      String password,
      String byear,
      String bmonth,
      String bday,
      String gender,
      String emailorsms,
      String s,
      GlobalKey<State> keyLoader,
      BuildContext context,
      String date,var fcmToken) {
    print("call==== SignupBLOC");

    _streamController = StreamController();
    _signupRepository = SignupRepository();

    fetchSingupData(email, fname, lname, password, byear, bmonth, bday, gender,
        emailorsms, s, keyLoader, context, date,fcmToken);
  }

  fetchSingupData(
      String email,
      String fname,
      String lname,
      String password,
      String byear,
      String bmonth,
      String bday,
      String gender,
      String emailorsms,
      String s,
      GlobalKey<State> keyLoader,
      BuildContext context,
      String date,var fcmToken) async {
    try {
      print("call==== SignupBLOC 2 ");

      SignUpModel signUpModel = await _signupRepository!.fetchSign(email, fname,
          lname, password, byear, bmonth, bday, gender, emailorsms, s,fcmToken);

      SignupBlocDataSink.add(Response.completed(signUpModel));
      Navigator.pop(context);
      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
      String? _status = signUpModel.apiStatus;
      String? _text = signUpModel.apiText;
      String? _version = signUpModel.apiVersion;
      String _sid = signUpModel.data['session_id'];
      String _userid = signUpModel.data['user_id'];

      if (_status!.contains("200")) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('s', _sid);
        pref.setString('userid', _userid);
        signupLoginBloc('user_login', email, fname, password, byear, bmonth,
            bday, keyLoader, context, date,fcmToken);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => RegisterFirstScreen()));

      }

      SignupBlocDataSink.add(Response.completed(signUpModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(context, keyLoader, e.toString());
      print("Exception === $e");
    }
  }
}
