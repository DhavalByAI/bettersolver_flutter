import 'package:bettersolver/bloc/soicallinks_update_bloc.dart';
import 'package:bettersolver/bloc/userdetail_bloc.dart';
import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/screen/setting/seting_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SocialLinksScreen extends StatefulWidget {
  @override
  State<SocialLinksScreen> createState() => _SocialLinksScreenState();
}

class _SocialLinksScreenState extends State<SocialLinksScreen> {
  UserDetailBloc? _userDetailBloc;

  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController youtbeController = TextEditingController();
  TextEditingController linkdinController = TextEditingController();
  TextEditingController instaController = TextEditingController();

  final GlobalKey<State> _keyLoaderget = GlobalKey<State>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderforloder = GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userDetailBloc = UserDetailBloc(_keyLoaderget, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kWhite,
          title: Text(
            'SOCIAL LINKS',
            style: Palette.greytext20B,
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SettingScreen()));
                LoadingDialog.showLoadingDialog(context, _keyLoaderforloder);

                SocialLinksUpdateBloc(
                    facebookController.text,
                    twitterController.text,
                    youtbeController.text,
                    linkdinController.text,
                    instaController.text,
                    _keyLoader,
                    context);
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
        body: StreamBuilder(
          stream: _userDetailBloc!.userdetailblocDataStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );

                case Status.COMPLETED:
                  return _detail(snapshot.data.data);

                case Status.ERROR:
                  return const Text(
                    'Errror msg',
                  );
              }
            }
            return Container();
          },
        ));
  }

  Widget _detail(UserDetailModel userDetailModel) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      String profileimage = userDetailModel.user_data['avatar'];
      String username = userDetailModel.user_data['username'];
      String fname = userDetailModel.user_data['first_name'];
      String lname = userDetailModel.user_data['last_name'];

      facebookController.text = userDetailModel.user_data['facebook'];
      twitterController.text = userDetailModel.user_data['twitter'];

      youtbeController.text = userDetailModel.user_data['youtube'];
      linkdinController.text = userDetailModel.user_data['linkedin'];

      instaController.text = userDetailModel.user_data['instagram'];

      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 270,
              width: MediaQuery.of(context).size.width,
              decoration: Palette.loginGradient,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 250,
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
                                    image: CachedNetworkImageProvider(
                                        profileimage))),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          '$fname $lname',
                          style:
                              Palette.greytext16B.copyWith(color: Colors.black),
                        ),
                      ),
                      Text(
                        '@$username',
                        style: Palette.greytext16B,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              'FACEBOOK',
                              style: Palette.whiteText10,
                              colors: [kThemeColorBlue, kThemeColorGreen],
                            ),
                            TextField(
                              controller: facebookController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "user name",
                                hintStyle: Palette.greytext12,
                                // labelText: "Email",
                                labelStyle: GoogleFonts.reemKufi(
                                    color: const Color(0xFF424242)),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  // borderRadius: BorderRadius.circular(30.0),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
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
                              'TWITTER',
                              style: Palette.whiteText10,
                              colors: [kThemeColorBlue, kThemeColorGreen],
                            ),
                            TextField(
                              controller: twitterController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "username or link",
                                hintStyle: Palette.greytext12,

                                // labelText: "Email",
                                labelStyle: GoogleFonts.reemKufi(
                                    color: const Color(0xFF424242)),

                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  // borderRadius: BorderRadius.circular(30.0),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  // borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              'YOUTUBE',
                              style: Palette.whiteText10,
                              colors: [kThemeColorBlue, kThemeColorGreen],
                            ),
                            TextField(
                              controller: youtbeController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "youtube link",
                                hintStyle: Palette.greytext12,
                                // labelText: "Email",
                                labelStyle: GoogleFonts.reemKufi(
                                    color: const Color(0xFF424242)),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  // borderRadius: BorderRadius.circular(30.0),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
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
                              'LINKEDIN',
                              style: Palette.whiteText10,
                              colors: [kThemeColorBlue, kThemeColorGreen],
                            ),
                            TextField(
                              controller: linkdinController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "linkdin link",
                                hintStyle: Palette.greytext12,

                                // labelText: "Email",
                                labelStyle: GoogleFonts.reemKufi(
                                    color: const Color(0xFF424242)),

                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  // borderRadius: BorderRadius.circular(30.0),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  // borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: GradientText(
                      'INSTAGRAM',
                      style: Palette.whiteText10,
                      colors: [kThemeColorBlue, kThemeColorGreen],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      controller: instaController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "user name",
                        hintStyle: Palette.greytext12,
                        // labelText: "Email",
                        labelStyle: GoogleFonts.reemKufi(
                            color: const Color(0xFF424242)),
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
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
