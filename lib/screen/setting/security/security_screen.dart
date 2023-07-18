import 'package:bettersolver/screen/setting/security/mangaesession_screen.dart';
import 'package:bettersolver/screen/setting/security/password_screen.dart';
import 'package:bettersolver/screen/setting/security/privacy_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhite,

        title: Text(
          'SECURITY',
          style: Palette.greytext20B,
        ),
        // actions: [
        //   Container(
        //     height: 50,
        //     width: 50,
        //     margin: EdgeInsets.only(right: 5),
        //     decoration: BoxDecoration(
        //         image: DecorationImage(
        //             fit: BoxFit.cover,
        //             image: AssetImage('assets/images/checkicon.png')
        //         )
        //     ),
        //   )
        // ],
      ),
      body: Column(
        children: [
          Container(
            height: 30,
            decoration: Palette.loginGradient,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25))),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 20, right: 15),
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
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/privacyicon.png'))),
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 50,
                  decoration: Palette.cardShapGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                        decoration: BoxDecoration(
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
                                    builder: (context) => PrivacyScreen()));
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'PRIVACY',
                                    style: Palette.greytext12,
                                  )),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.arrow_right,
                                      color: kThemeColorBlue,
                                    ),
                                  )
                                ],
                              )),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 20, right: 15),
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
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/passwordicon.png'))),
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 50,
                  decoration: Palette.cardShapGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                        decoration: BoxDecoration(
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
                                    builder: (context) => PasswordScreen()));
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'PASSWORD',
                                    style: Palette.greytext12,
                                  )),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.arrow_right,
                                      color: kThemeColorBlue,
                                    ),
                                  )
                                ],
                              )),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 20, right: 15),
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
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/seesionicon.png'))),
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 50,
                  decoration: Palette.cardShapGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                        decoration: BoxDecoration(
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
                                        ManageSessionScreen()));
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'MANAGE SESSION',
                                    style: Palette.greytext12,
                                  )),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.arrow_right,
                                      color: kThemeColorBlue,
                                    ),
                                  )
                                ],
                              )),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
