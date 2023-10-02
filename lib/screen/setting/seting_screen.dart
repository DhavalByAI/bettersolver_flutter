import 'package:bettersolver/bloc/delete_bloc.dart';
import 'package:bettersolver/screen/auth/login.dart';
import 'package:bettersolver/screen/profile/profile_bio.dart';
import 'package:bettersolver/screen/profile/profile_general_screen.dart';
import 'package:bettersolver/screen/setting/blockuser/blockuser_screen.dart';
import 'package:bettersolver/screen/setting/coverpage/coverpage_screen.dart';
import 'package:bettersolver/screen/setting/feedback/feedback_screen.dart';
import 'package:bettersolver/screen/setting/my_information/information_screen.dart';
import 'package:bettersolver/screen/setting/notification/notification_screen.dart';
import 'package:bettersolver/screen/setting/security/security_screen.dart';
import 'package:bettersolver/screen/setting/sociallinks/sociallinks_screen.dart';
import 'package:bettersolver/screen/setting/verification/verification_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<State> _KeyLoader = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhite,
        title: Text(
          'SETTING',
          style: Palette.greytext20B,
        ),
        actions: [
          InkWell(
            onTap: () {
              showAlertDialog(context: context);
            },
            child: Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.only(left: 15),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logouticon.png'))),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 30,
            decoration: Palette.loginGradient,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25))),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // color: Colors.white,
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/general.png'))
                                ),
                                // color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      Image.asset('assets/images/general.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileGeneralScreen()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            height: 50,
                            decoration: Palette.cardShapGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: kWhite,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(25))),
                                  child: _textDesign('GENERAL')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // height: 50,
                                // width: 50,

                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/profileicon.png'))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      Image.asset('assets/images/profile1.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(25))),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BioProfile()));
                                    },
                                    child: _textDesign('PROFILE'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // height: 50,
                                // width: 50,

                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/securityicon.png'))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                      'assets/images/security1.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(25))),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SecurityScreen()));
                                    },
                                    child: _textDesign('SECURITY'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // height: 50,
                                // width: 50,

                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/socialicon.png'))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                      'assets/images/socialLink1.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(25))),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SocialLinksScreen()));
                                    },
                                    child: _textDesign('SOCIAL LINKS'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // height: 50,
                                // width: 50,

                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/displayicon.png'))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      Image.asset('assets/images/display1.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(25))),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CoverPageScreen()));
                                    },
                                    child: _textDesign('DISPLAY & COVERPAGE'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // height: 50,
                                // width: 50,

                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/blockusericon.png'))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      Image.asset('assets/images/block1.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(25))),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BlockUserScreen()));
                                    },
                                    child: _textDesign('BLOCK USER'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // height: 50,
                                // width: 50,

                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/notificationicon.png'))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                      'assets/images/notification1.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(25))),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (contex) =>
                                                  NotificationScreen()));
                                    },
                                    child:
                                        _textDesign('NOTIFICATION SETTINGS'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // height: 50,
                                // width: 50,

                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/verificationicon.png'))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                      'assets/images/verification1.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(25))),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const VerificationScreen()));
                                    },
                                    child: _textDesign('VERIFICATION'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // height: 50,
                                // width: 50,

                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/feedbackicon.png'))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                      'assets/images/feedback1.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(25))),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FeedBackScreen()));
                                    },
                                    child: _textDesign('FEEDBACK'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // height: 50,
                                // width: 50,

                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/informationicon.png'))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                      'assets/images/myInformation1.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(25))),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const InformationScreen()));
                                    },
                                    child: _textDesign('MY INFORMATION'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      children: [
                        Container(
                          decoration: Palette.RoundGradient,
                          height: 50,
                          width: 50,
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // height: 50,
                                // width: 50,

                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage(
                                  //         'assets/images/deleteicon.png'))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      Image.asset('assets/images/delete.png'),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showAlertDialogForDelete(
                                context: context, KeyLoader: _KeyLoader);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            height: 50,
                            decoration: Palette.cardShapGradient,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: kWhite,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(25))),
                                  child: _textDesign('DELETE ACCOUNT')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textDesign(String text) {
    return Container(
        margin: const EdgeInsets.only(left: 15),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
                child: Text(
              text,
              style: Palette.greytext12,
            )),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.arrow_right,
                color: kThemeColorBlue,
              ),
            )
          ],
        ));
  }

  showAlertDialog({required BuildContext context}) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      child: Text(
        "Cancel",
        style: GoogleFonts.reemKufi(fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = MaterialButton(
      child: Text(
        "Yes",
        style: GoogleFonts.reemKufi(fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, false);
        logoutUser();
        // Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogForDelete(
      {required BuildContext context, required GlobalKey<State> KeyLoader}) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      child: Text(
        "Cancel",
        style: GoogleFonts.reemKufi(fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = MaterialButton(
      child: Text(
        "Yes",
        style: GoogleFonts.reemKufi(fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, false);
        DeleteBloc(KeyLoader, context);
        logoutUser();
        // Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete"),
      content: const Text("Are you sure you want to delete account?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void logoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }
}
