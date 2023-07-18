import 'dart:convert';
import 'dart:math';

import 'package:bettersolver/bloc/loginbloc.dart';
import 'package:bettersolver/screen/auth/signup.dart';
import 'package:bettersolver/screen/auth/webview.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import '../../utils/base_constant.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
  ],
);

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotPasswordController = TextEditingController();

  bool _obsecurePass = true;

  String type = 'user_login';
  int s = 0;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> keyLoader = GlobalKey<State>();

  final GlobalKey<State> _keyError = GlobalKey<State>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  var fcmToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    setupToken();
    var random = Random();
    s = random.nextInt(100000);

    print("::::::::::::$s");
  }

  setupToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcmToken_login:::::::::::::::::::$fcmToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
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
              "Log In",
              style: Palette.blackText30,
            ),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Text(
          //   "Enter Your Email and Password",
          //   style: Palette.blackText11,
          // ),
          const SizedBox(
            height: 20,
          ),
          _emailEditText(emailController, 'Username or Email'),
          _passEditText1(passwordController, 'Password'),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: const Alignment(0.9, -0.5),
            child: InkWell(
              onTap: () {
                showDialog(
                  barrierColor: Colors.black.withOpacity(0.8),
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Forgot Password'),
                      content: TextField(
                        controller: forgotPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                        ),
                      ),
                      actions: [
                        MaterialButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        MaterialButton(
                          child: Container(
                            decoration: Palette.buttonGradient,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Send Link",
                                style:
                                    Palette.whiettext20B.copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            EasyLoading.show();
                            String url =
                                '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=reset_pass';
                            try {
                              var response = await http.post(
                                Uri.parse(url),
                                body: {
                                  'email': forgotPasswordController.text,
                                },
                              );

                              var decode = json.decode(response.body);
                              print(decode);

                              if (response.statusCode == 200) {
                                if (decode['api_status'] == '200') {
                                  EasyLoading.showSuccess(
                                      "Link Has Been Sended to Your Email ID");
                                  Get.back();
                                  Get.back();
                                } else if (decode['api_status'] == '400') {
                                  print("Failed");
                                  EasyLoading.showError(
                                      decode['errors']['error_text']);
                                }
                              } else {}
                            } catch (e) {
                              EasyLoading.showError("Something Went Wrong");
                            }

                            // Navigator.of(context).pop();
                          },
                        ),
                        // Container(
                        //   decoration: Palette.buttonGradient,
                        //   child: InkWell(
                        //     onTap: () {},
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Center(
                        //         child: Text(
                        //           "Send Link",
                        //           style: Palette.whiettext20B,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    );
                  },
                );
              },
              child: Text(
                "Forgot Password?",
                style: Palette.blackText12,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
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
          //           "SIGN IN",
          //           style: GoogleFonts.reemKufi(
          //               fontSize: 18,
          //               fontWeight: FontWeight.w700,
          //               fontStyle: FontStyle.normal,
          //               color: Colors.white),
          //         ),
          //       )),
          // ),

          _gradientBtn(),
          const SizedBox(
            height: 25,
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(
                'Sign In',
                style: Palette.whiteText15,
                colors: const [kThemeColorBlue, kThemeColorGreen],
              ),
              const SizedBox(
                width: 5,
              ),
              Text("with", style: Palette.greytext14),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  //    _handleGoogleSignIn();
                },
                child: Card(
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
                                  'assets/images/facebook_icon.png'))),
                    ),
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
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an Account?",
                style: Palette.greytext14,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: const Text("Sign up"))
            ],
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
        ],
      ),
    ));
  }

  var name;
  var email;
  var image;
  var gid;

  Future<void> _handleGoogleSignIn() async {
    try {
      await googleSignIn.signIn();
      GoogleSignInAccount? user = await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await user!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // final AuthCredential credential = GoogleAuthProvider.getCredential(
      //   accessToken: googleSignInAuthentication.accessToken,
      //   idToken: googleSignInAuthentication.idToken,
      // );

      print('userData:::::::::::::::::::::$user');
      if (user != null) {
        setState(() {
          name = user.displayName;
          email = user.email;
          image = user.photoUrl ?? "";
          gid = user.id;
        });

        print('name:::::::::::$name');
        print('email:::::::::::$email');
        print('image:::::::::::$image');
        print('gid:::::::::::$gid');
        // LoadingDialog.showLoadingDialog(context, _keyLoader);

        //SharedPreferences pref = await SharedPreferences.getInstance();

        // var req = {
        //   'name': user.displayName,
        //   'email': user.email,
        //   'id': user.id,
        //   'from_mobile': '1',
        // };
        //googleSignIn.disconnect();
      } else {
        ErrorDialouge.showErrorDialogue(
            context, _keyError, "Google login failed..!");
      }
    } catch (error) {
      Navigator.pop(context);
      print(error);
    }
  }

  // Widget _otptextFild(){
  //   return Container(
  //     margin: EdgeInsets.only(top: 30),
  //     child: OTPTextField(
  //       length: 4,
  //       width: MediaQuery.of(context).size.width,
  //       fieldWidth: 20,
  //       style: Palette.blacktext16,
  //       // GoogleFonts.reemKufi(
  //       //     fontSize: 17
  //       //
  //       // ),
  //       textFieldAlignment: MainAxisAlignment.start,
  //       fieldStyle: FieldStyle.underline,
  //       spaceBetween: 10,
  //
  //       onCompleted: (pin) {
  //         print("Completed: " + pin);
  //       },
  //     ),
  //   );
  // }

  // Widget _phonEdititext(TextEditingController controller, String label) {
  //   return TextField(
  //     controller: controller,
  //     keyboardType: TextInputType.number,
  //     style: GoogleFonts.reemKufi(
  //           fontWeight: FontWeight.w500, fontSize: 16),
  //     decoration: InputDecoration(
  //       fillColor: kWhite,
  //       filled: true,
  //       // enabledBorder: OutlineInputBorder(
  //       //   borderSide: BorderSide(color: kDarkThemeColor, width: 2.0),
  //       //   borderRadius: BorderRadius.circular(7.0),
  //       // ),
  //       // focusedBorder: OutlineInputBorder(
  //       //   borderSide: BorderSide(color: kred, width: 2.0),
  //       //   borderRadius: BorderRadius.circular(7.0),
  //       // ),
  //       // border: OutlineInputBorder(
  //       //   borderSide:
  //       //       BorderSide(color: kThemeColor.withOpacity(0.1), width: 2.0),
  //       //   borderRadius: BorderRadius.circular(7.0),
  //       // ),
  //       // disabledBorder: OutlineInputBorder(
  //       //   borderSide:
  //       //       BorderSide(color: kThemeColor.withOpacity(0.1), width: 2.0),
  //       //   borderRadius: BorderRadius.circular(7.0),
  //       // ),
  //       contentPadding: const EdgeInsets.all(15.0),
  //       hintText: label,
  //       labelStyle: GoogleFonts.reemKufi(color: Colors.grey),
  //     ),
  //   );
  // }

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
          style:
              GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 12),
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
            labelStyle: GoogleFonts.reemKufi(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _passEditText1(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
              colors: [kThemeColorBlue, kThemeColorGreen])),
      child: Padding(
        padding: const EdgeInsets.all(0.9),
        child: TextField(
          controller: controller,
          obscureText: _obsecurePass,
          keyboardType: TextInputType.text,
          style:
              GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 12),
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
            labelStyle: GoogleFonts.reemKufi(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _gradientBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: Palette.buttonGradient,
      child: InkWell(
        onTap: () {
          if (emailController.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "Please enter your username");
          } else if (passwordController.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "Please enter your password");
          } else {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Home()));
            LoadingDialog.showLoadingDialog(context, _keyLoader);
            // Loading();
            LoginBloc(type, emailController.text, passwordController.text,
                s.toString(), keyLoader, context, fcmToken);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Log In",
              style: Palette.whiettext20B,
            ),
          ),
        ),
      ),
    );
  }
}
