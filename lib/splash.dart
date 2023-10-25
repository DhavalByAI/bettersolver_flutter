import 'dart:async';
import 'package:bettersolver/bottom_navigation.dart';
import 'package:bettersolver/screen/auth/login.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/base_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/userdetail_model.dart';
import 'utils/apiprovider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<State> _keyError = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.chasingDots
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..maskType = EasyLoadingMaskType.black
      ..dismissOnTap = false;
    // navigateUser();
    // _onBoardingApi();
    Timer(const Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 1.5 seconds
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: Palette.mainGradient,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/bettersolver_logo.png'))),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.9),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'from',
                  style: Palette.whiettext20B.copyWith(
                      fontSize: 18, color: Colors.black.withOpacity(0.5)),
                ),
                // const SizedBox(
                //   height: 2,
                // ),
                Text('Better Solver',
                    style: GoogleFonts.reemKufi(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Colors.black.withOpacity(0.5))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateUser() async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile ||connectivityResult == ConnectivityResult.wifi) {

    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? login = pref.getBool('login');
    try {
      Future<UserDetailModel> fetchUserDetail() async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? s = pref.getString('s');
        String? userid = pref.getString('userid');

        final requestBody = {
          "user_id": userid,
          "user_profile_id": userid,
          "s": s
        };
        print(requestBody);

        final response = await ApiProvider().httpMethodWithoutToken(
          'post',
          'demo2/app_api.php?application=phone&type=get_user_data',
          requestBody,
        );

        return UserDetailModel.fromJson(response);
      }

      currUser = await fetchUserDetail();
      pref.setString('profileimage', currUser!.user_data['avatar']);
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false);
    }

    print('login----$login');
    if (login == true && currUser!.api_status == "200" && currUser != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false);
    }
  }
}
