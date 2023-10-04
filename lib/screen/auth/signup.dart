// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:bettersolver/bloc/signupbloc.dart';
import 'package:bettersolver/screen/auth/login.dart';
import 'package:bettersolver/screen/auth/terms.dart';
import 'package:bettersolver/screen/auth/webview.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateofbirthController = TextEditingController();

  int _radioValue = 0;

  String type = "";

  //  DateTime selectedDob = DateTime.now();

  bool isChecked = false;

  DateTime selectedDate = DateTime.now();

  String formattedDob = "";

  bool _obsecurePass = true;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> keyLoader = GlobalKey<State>();

  String emailOrsms = 'sms';
  int s = 0;

  var fcmToken;

  void _handleRadioValueChange(value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 1:
          type = 'male';
          break;
        case 2:
          type = 'female';
          break;
        case 3:
          type = 'others';
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupToken();
    var random = Random();
    s = random.nextInt(100000);

    print("::::::::::::$s");
  }

  setupToken() async {
    fcmToken = 'token';
    print('fcmToken_sign_up:::::::::::::::::::$fcmToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 230,
            decoration: Palette.loginGradient,
            child: Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/bettersolver_logo.png'))),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              "Sign Up",
              style: Palette.blackText30,
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //   child: Text(
          //     "",
          //     style: Palette.blackText11,
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),

          _firstEditText(firstnameController, 'First Name'),
          _secondEditText(lastnameController, 'Surname'),
          _emailEditText(emailController, 'Email Address'),
          _passwordEditText(passwordController, 'New Password'),
          // _DateofBirthText(dateofbirthController, 'Date of Birth'),
          _calenderDobDate(),
          const SizedBox(
            height: 10,
          ),

          // Align(
          //   child: Text(
          //     "Forget Password?",
          //     style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 12),
          //   ),
          //   alignment: Alignment(0.9, -0.5),
          // ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.bottomLeft,
            child: Text(
              "Gender",
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  decoration: Palette.buttonGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(0.8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        color: kWhite,
                      ),
                      // decoration: Palette.buttonGradient,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 36,
                            width: 32,
                            child: Radio(
                              activeColor: kThemeColorBlue,
                              value: 2,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 8),
                              child:
                                  Text('Female', style: Palette.themText15L)),
                        ],
                      ),
                    ),
                  )),
              Container(
                  decoration: Palette.buttonGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(0.8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        color: kWhite,
                      ),
                      // decoration: Palette.buttonGradient,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 36,
                            width: 32,
                            child: Radio(
                              activeColor: kThemeColorBlue,
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Text('Male', style: Palette.themText15L)),
                        ],
                      ),
                    ),
                  )),
              Container(
                  decoration: Palette.buttonGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(0.8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        color: kWhite,
                      ),
                      // decoration: Palette.buttonGradient,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 36,
                            width: 32,
                            child: Radio(
                              activeColor: kThemeColorBlue,
                              value: 3,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Text('Custom(them)',
                                  style: Palette.themText15L)),
                        ],
                      ),
                    ),
                  )),
            ],
          ),

          // RaisedButton(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   padding: EdgeInsets.all(0.0),
          //   onPressed: () {},
          //   child: Ink(
          //       decoration: Palette.buttonGradient,
          //       child: Container(
          //         constraints: BoxConstraints(
          //           maxWidth: 350,
          //           minHeight: 50,
          //         ),
          //         alignment: Alignment.center,
          //         child: Text(
          //           "SIGN UP",
          //           style: GoogleFonts.roboto(
          //               fontSize: 18,
          //               fontWeight: FontWeight.w700,
          //               fontStyle: FontStyle.normal,
          //               color: Colors.white),
          //         ),
          //       )),
          // ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                checkColor: Colors.white,
                //fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'By Signing up, you agree to our',
                    style: Palette.greytext12,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Terms());
                    },
                    child: Text(
                      ' Terms & Policies',
                      style: Palette.greytext12
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(
            height: 10,
          ),
          _gradientBtn(),
          const SizedBox(
            height: 20,
          ),

          Row(children: <Widget>[
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 50.0, right: 20.0),
                  child: const Divider(
                    thickness: 1,
                    indent: 40,
                  )),
            ),
            Text("OR", style: Palette.greytext14),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 50.0),
                  child: const Divider(
                    thickness: 1,
                    endIndent: 40,
                  )),
            ),
          ]),
          const SizedBox(
            height: 2,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  child: GradientText(
                    'Log In',
                    style: Palette.whiteText15,
                    colors: const [kThemeColorBlue, kThemeColorGreen],
                  )),
              Text(
                "with",
                style: Palette.greytext14,
              ),
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 8,
                color: kWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/facebook_icon.png'))),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Card(
                elevation: 8,
                color: kWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/twitter_icon.png'))),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Card(
                elevation: 8,
                color: kWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/instagram_icon.png'))),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: Palette.greytext14,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Text(
                  " Log In",
                  style: Palette.greytext14.copyWith(color: Colors.blue),
                ),
              ),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => Login()));
              //     },
              //     child: Text("Log In"))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => WebViewScreen(
                        title: 'About us',
                        url: 'https://bettersolver.com/demo2/terms/about-us'));
                  },
                  child: Text(
                    "About us",
                    style: Palette.greytext14.copyWith(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.circle,
                    size: 6,
                    color: kGreyone.withOpacity(0.5),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => WebViewScreen(
                        title: 'Terms & Policies',
                        url:
                            'https://bettersolver.com/demo2/terms/privacy-policy'));
                  },
                  child: Text(
                    "Terms & Policies",
                    style: Palette.greytext14.copyWith(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.circle,
                    size: 6,
                    color: kGreyone.withOpacity(0.5),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => WebViewScreen(
                        title: 'Contact us',
                        url: 'https://bettersolver.com/demo2/contact-us'));
                  },
                  child: Text(
                    "Contact us",
                    style: Palette.greytext14.copyWith(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }

  Widget _firstEditText(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
              colors: [kThemeColorBlue, kThemeColorGreen])),
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            prefixIcon: const Icon(Icons.person),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(15.0),
            hintText: label,
            labelStyle: GoogleFonts.roboto(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _secondEditText(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
              colors: [kThemeColorBlue, kThemeColorGreen])),
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            prefixIcon: const Icon(Icons.person),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(15.0),
            hintText: label,
            labelStyle: GoogleFonts.roboto(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _emailEditText(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
              colors: [kThemeColorBlue, kThemeColorGreen])),
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            prefixIcon: const Icon(Icons.mail),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(15.0),
            hintText: label,
            labelStyle: GoogleFonts.roboto(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _passwordEditText(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
              colors: [kThemeColorBlue, kThemeColorGreen])),
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: TextField(
          controller: controller,
          obscureText: _obsecurePass,
          keyboardType: TextInputType.text,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obsecurePass = !_obsecurePass;
                });
              },
              child: Icon(
                _obsecurePass ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(15.0),
            hintText: label,
            labelStyle: GoogleFonts.roboto(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _calenderDobDate() {
    return Container(
      decoration: Palette.buttonGradient,
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: kWhite,
                border: Border.all(color: Colors.transparent, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(33.0))),
            // decoration: Palette.buttonGradient,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Icon(Icons.calendar_today,  size: 17.0),
                  const Icon(
                    Icons.calendar_today_rounded,
                    color: kGreyone,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      formattedDob.isEmpty
                          ? '    Date of Birth'
                          : "$selectedDate".split(' ')[0],
                      //   formattedDob != null ? "$selectedDate".split(' ')[0] : "DOB",
                      style: GoogleFonts.roboto(
                          color: kDarkThemecolor, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDob = DateFormat('dd-MM-yyyy').format(selectedDate);
        print('seleted::::::::::Date $formattedDob');
      });
    }
  }

  // Future<void> _selectDobDate(BuildContext context)  async {
  //   final DateTime picked =  showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(1900, 1),
  //       lastDate: DateTime.now()) as DateTime;
  //   if (picked != null && picked != selectedDob) {
  //     setState(() {
  //       selectedDob = picked;
  //       formattedDob = DateFormat('dd-MM-yyyy').format(selectedDob);
  //       print('Date of birth :: $formattedDob');
  //     });
  //   }
  // }

  Widget _gradientBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: Palette.buttonGradient,
      child: InkWell(
        onTap: () {
          var day;
          var month;
          var year;

          print('-*-*-*--*-*$formattedDob');

          if (formattedDob.isNotEmpty) {
            //String str =formattedDob;
            day = formattedDob.substring(0, 2);
            month = formattedDob.substring(3, 5);
            year = formattedDob.substring(6, 10);
            print('::::::::::::$day');
            print('::::::::::::$month');
            print('::::::::::::$year');
          }

          if (firstnameController.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "Please enter your username");
          } else if (lastnameController.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "Please enter your lastname");
          } else if (emailController.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "Please enter your email");
          } else if (passwordController.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "Please enter your password");
          } else if (formattedDob.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "Please enter your Birthday");
          } else if (type == '') {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "Please select your gender");
          } else if (isChecked == false) {
            ErrorDialouge.showErrorDialogue(context, _keyLoader, "Accept T&C");
          } else {
            LoadingDialog.showLoadingDialog(context, _keyLoader);
            SignupBloc(
                emailController.text,
                firstnameController.text,
                lastnameController.text,
                passwordController.text,
                year,
                month,
                day,
                type,
                emailOrsms,
                s.toString(),
                keyLoader,
                context,
                formattedDob,
                fcmToken);
          }
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => RegisterFirstScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Sign up",
              style: Palette.whiettext20B,
            ),
          ),
        ),
      ),
    );
  }
}
