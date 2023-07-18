import 'package:bettersolver/bloc/change_password_bloc.dart';
import 'package:bettersolver/screen/setting/security/security_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PasswordScreen extends StatefulWidget {
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();

  GlobalKey<State> _keyLoader = GlobalKey<State>();

  var auth;
  List authList = ['Disable ', 'Enable'];

  String? userName;
  String? fullName;
  String? avtarURL;
  String? coverURL;
  GetShared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('userName');
    fullName = pref.getString('fullName');
    avtarURL = pref.getString('avtarURL');
    coverURL = pref.getString('coverURL');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    GetShared();
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        title: Text(
          'PASSWORD',
          style: Palette.greytext20B,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => SecurityScreen()));

              setState(() {
                if (currentPassController.text.isEmpty) {
                  ErrorDialouge.showErrorDialogue(
                      context, _keyLoader, "Enter current password");
                } else if (newPassController.text.isEmpty) {
                  ErrorDialouge.showErrorDialogue(
                      context, _keyLoader, "Enter new password");
                } else if (repeatPassController.text.isEmpty) {
                  ErrorDialouge.showErrorDialogue(
                      context, _keyLoader, "Enter repeat password");
                } else if (newPassController.text !=
                    repeatPassController.text) {
                  ErrorDialouge.showErrorDialogue(
                      context, _keyLoader, "password diden't match");
                } else {
                  ChangePasswordBloc(
                      currentPassController.text,
                      newPassController.text,
                      repeatPassController.text,
                      _keyLoader,
                      context);
                }
              });
            },
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(right: 5),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/checkicon.png'))),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 290,
              width: MediaQuery.of(context).size.width,
              decoration: Palette.loginGradient,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 270,
                    decoration: const BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0))),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.only(top: 30),
                        decoration: Palette.RoundGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(avtarURL ?? ""))),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          //alignment: Alignment.bottomCenter,
                          child: Text(
                            fullName ?? "",
                            style: Palette.greytext18B,
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          //alignment: Alignment.bottomCenter,
                          child: Text(
                            '@$userName',
                            style: Palette.greytext14,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _currentPassword(),
            const SizedBox(
              height: 20,
            ),
            _newAndRepeatField(),
            const SizedBox(
              height: 20,
            ),
            _authentication()
          ],
        ),
      ),
    );
  }

  Widget _currentPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: GradientText(
            'CURRENT PASSWORD',
            style: Palette.whiteText10,
            colors: [kThemeColorBlue, kThemeColorGreen],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: currentPassController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Type Here",
              hintStyle: Palette.greytext12,

              // labelText: "Email",
              hintMaxLines: 2,
              labelStyle: GoogleFonts.reemKufi(color: const Color(0xFF424242)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _newAndRepeatField() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                'NEW PASSWORD',
                style: Palette.whiteText10,
                colors: [kThemeColorBlue, kThemeColorGreen],
              ),
              TextField(
                controller: newPassController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "new password",
                  hintStyle: Palette.greytext12,
                  // labelText: "Email",
                  labelStyle:
                      GoogleFonts.reemKufi(color: const Color(0xFF424242)),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    // borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    // borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                'REPEAT PASSWORD',
                style: Palette.whiteText10,
                colors: [kThemeColorBlue, kThemeColorGreen],
              ),
              TextField(
                controller: repeatPassController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "repeat password",
                  hintStyle: Palette.greytext12,

                  // labelText: "Email",
                  labelStyle:
                      GoogleFonts.reemKufi(color: const Color(0xFF424242)),

                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    // borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    // borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ))
      ],
    );
  }

  Widget _authentication() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: GradientText(
            'TWO - FACTOR AUTHENTICATION',
            style: Palette.whiteText10,
            colors: [kThemeColorBlue, kThemeColorGreen],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width / 2,
          child: DropdownButtonFormField(
            // icon: Icon(Icons.add_location),
            style: GoogleFonts.reemKufi(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
            value: auth,
            hint: Text(
              'Disable',
              style: GoogleFonts.reemKufi(
                  fontWeight: FontWeight.w400, fontSize: 12),
            ),
            items: authList.map((item) {
              return DropdownMenuItem(
                child: Text(
                  item,
                  style: Palette.greytext15,
                ),
                value: item,
              );
            }).toList(),
            decoration: const InputDecoration(
              fillColor: kWhite,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding: EdgeInsets.all(10.0),
            ),
            onChanged: (newValue) {
              setState(() {
                auth = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
