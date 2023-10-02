import 'package:bettersolver/bloc/famoususer_bloc.dart';
import 'package:bettersolver/bloc/signup_step_follow_bloc.dart';
import 'package:bettersolver/bottom_navigation.dart';
import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterThiredScreen extends StatefulWidget {
  String? uid, sid;

  RegisterThiredScreen({super.key, this.uid, this.sid});

  @override
  State<RegisterThiredScreen> createState() => _RegisterThiredScreenState();
}

class _RegisterThiredScreenState extends State<RegisterThiredScreen> {
  FamousUserBloc? _famousUserBloc;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> keyLoader = GlobalKey<State>();

  var _userid;

  var _sid;

  List userlist = [];

  List isrequets = [];

  final bool _isrequest = false;

  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _famousUserBloc =
        FamousUserBloc(widget.uid!, widget.sid!, _keyLoader, context);

    // getprefrancedata();
  }

  // getprefrancedata() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //  setState(() {
  //    _userid = pref.getString("userid");
  //    _sid = pref.getString("s");
  //  });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 8,
                  color: kWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33)),
                  child: Container(
                      decoration: Palette.buttonGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(0.9),
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            // decoration: BoxDecoration(
                            //     color: kWhite,
                            //     borderRadius: BorderRadius.circular(33)
                            // ),
                            child: Center(
                                child: Text(
                              '1',
                              style: Palette.whiteText15,
                            ))),
                      )
                      //Card(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(50)),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(top: 10,bottom: 10,left: 12,right: 12),
                      //       child: Text('1',style: Palette.themText15,)
                      //     ),
                      //   ),

                      ),
                ),
                // Container(
                //     margin: EdgeInsets.only(left: 1,right: 1),
                //     child: const DottedLine()),
                Text(
                  '- - - - - - - - - - - - -',
                  style: GoogleFonts.reemKufi(color: kThemeColorBlue),
                ),
                Card(
                  elevation: 8,
                  color: kWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33)),
                  child: Container(
                      decoration: Palette.buttonGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(0.9),
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            // decoration: BoxDecoration(
                            //     color: kWhite,
                            //     borderRadius: BorderRadius.circular(33)
                            // ),
                            child: Center(
                                child: Text(
                              '2',
                              style: Palette.whiteText15,
                            ))),
                      )
                      //Card(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(50)),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(top: 10,bottom: 10,left: 12,right: 12),
                      //       child: Text('1',style: Palette.themText15,)
                      //     ),
                      //   ),

                      ),
                ),
                Text(
                  '- - - - - - - - - - - - -',
                  style: GoogleFonts.reemKufi(color: kThemeColorGreen),
                ),
                Card(
                  elevation: 8,
                  color: kWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33)),
                  child: Container(
                      decoration: Palette.buttonGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(0.9),
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(33)),
                            child: Center(
                                child: Text(
                              '3',
                              style: Palette.themText15,
                            ))),
                      )
                      //Card(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(50)),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(top: 10,bottom: 10,left: 12,right: 12),
                      //       child: Text('1',style: Palette.themText15,)
                      //     ),
                      //   ),

                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Card(
            elevation: 8,
            color: kWhite,
            margin: const EdgeInsets.only(left: 40, right: 40),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
            child: Container(
                decoration: Palette.buttonGradient,
                child: Padding(
                    padding: const EdgeInsets.all(0.9),
                    child: Container(
                      height: 370,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(33)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: Text('Follow People',
                                    style: Palette.blackText30)),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Please follow at least three users & navigate to home feeds',
                              style: Palette.blackText11,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: 260,
                              child: StreamBuilder(
                                  // stream: _famousUserBloc
                                  //     .FamousUserBlocDataStream,
                                  stream:
                                      _famousUserBloc!.FamousUserBlocDataStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      switch (snapshot.data.status) {
                                        case Status.LOADING:
                                          return Loading(
                                              loadingMessage:
                                                  snapshot.data.message);
                                        case Status.COMPLETED:
                                          return _adduserList(
                                              snapshot.data.data);
                                        case Status.ERROR:
                                          return Container(
                                            child: const Text(
                                              'Errror msg',
                                            ),
                                          );
                                      }
                                    }
                                    return Container();
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ))),
          ),
          const SizedBox(height: 20),
          _gradientBtn()
        ],
      ),
    ));
  }

  Widget _adduserList(CommonDataModel commonDataModel) {
    userlist.addAll(commonDataModel.data);

    return GridView.builder(
      itemCount: userlist != null ? userlist.length : 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        //  crossAxisSpacing: 5.0,
        // mainAxisSpacing: 5.0,
        childAspectRatio: 0.84,
      ),
      itemBuilder: (BuildContext context, int index) {
        var image = userlist[index]['avatar'];
        var username = userlist[index]['username'];
        var userId = userlist[index]['user_id'];

        // //  isrequets.add(false);
        //     for(int i=0; i < userlist.length; i++) {
        //         isrequets.add(false);
        //       }
        //
        //     bool isSelected = false;
        //     String subIndId = userlist[index]['id'].toString();
        //
        //     for (var j = 0; j < userlist.length; j++) {
        //       if (subIndId == userlist[j]) {
        //         isSelected = false;
        //       }
        //     }

        return Column(
          children: [
            Container(
              height: 120,
              width: 120,
              // margin: EdgeInsets.only(right: 10, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(image))),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '$username',
                        style: Palette.themText11,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  //  Spacer(),
                  InkWell(
                      onTap: () {
                        setState(() {
                          LoadingDialog.showLoadingDialog(context, _keyLoader);
                          if (userlist.contains(index)) {
                            setState(() => userlist.remove(index));
                            count--;
                          } else {
                            setState(() => userlist.add(index));
                            count++;
                          }
                          SignupStepFollowBloc(widget.uid!, widget.sid!, userId,
                              keyLoader, context);
                        });
                      },
                      child: userlist.contains(index)
                          ? Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/accepticon.png'))),
                            )
                          : Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/requesticon.png'))),
                            )),
                ],
              ),
            ),
          ],
        );
      },
    );
    // ListView.builder(
    //     itemCount: userlist != null ? userlist.length:0,
    //     scrollDirection: Axis.horizontal,
    //     itemBuilder: (context, index) {
    //
    //       var image = userlist[index]['avatar'] ;
    //       var username = userlist[index]['username'];
    //       var userId = userlist[index]['user_id'];
    //
    //
    //       return Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             height: 100,
    //             width: 100,
    //             margin: EdgeInsets.only(right: 15),
    //             decoration: BoxDecoration(
    //                 // borderRadius: BorderRadius.circular(10),
    //
    //                 image: DecorationImage(
    //                     image: CachedNetworkImageProvider(image))),
    //             alignment: Alignment.bottomRight,
    //             child: InkWell(
    //               onTap: (){
    //                 SignupStepFollowBloc(_userid,_sid,userId,keyLoader,context);
    //
    //               },
    //               child: Container(
    //                 height: 25,
    //                 width: 25,
    //                 margin: EdgeInsets.only(right: 5, bottom: 10),
    //                 decoration: BoxDecoration(
    //                     image: DecorationImage(
    //                         image:
    //                             AssetImage('assets/images/requesticon.png'))),
    //                 //    child: Icon(Icons.group_add_outlined,)
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 5,),
    //           Container(
    //             child: Text(
    //               '$username',
    //               style: Palette.themText11,
    //             ),
    //           )
    //         ],
    //       );
    //     }),
  }

  Widget _gradientBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: Palette.buttonGradient,
      child: InkWell(
        onTap: () {
          setState(() {
            print('count=$count');
            if (count >= 3) {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (_) => Home(),
              //   ),
              //
              // );

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false);
            } else {
              ErrorDialouge.showErrorDialogue(
                  context, _keyLoader, "Please follow at least three users");
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "SAVE & CONTINUE",
              style: Palette.whiettext18,
            ),
          ),
        ),
      ),
    );
  }
}
