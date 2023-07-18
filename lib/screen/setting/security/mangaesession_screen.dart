import 'package:bettersolver/bloc/logout_session_bloc.dart';
import 'package:bettersolver/bloc/mange_session_list_bloc.dart';
import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/screen/auth/login.dart';
import 'package:bettersolver/screen/setting/security/security_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageSessionScreen extends StatefulWidget {
  @override
  State<ManageSessionScreen> createState() => _ManageSessionScreenState();
}

class _ManageSessionScreenState extends State<ManageSessionScreen> {
  ManageSessionListBloc? _manageSessionListBloc;

  List sessionList = [];

  final GlobalKey<State> _keyLoaderget = new GlobalKey<State>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manageSessionListBloc = ManageSessionListBloc(_keyLoaderget, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        title: Text(
          'MANAGE SESSION',
          style: Palette.greytext20B,
        ),
        centerTitle: true,
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => SecurityScreen()));
        //     },
        //     child: Container(
        //       height: 50,
        //       width: 50,
        //       margin: EdgeInsets.only(right: 5),
        //       decoration: BoxDecoration(
        //           image: DecorationImage(
        //               fit: BoxFit.cover,
        //               image: AssetImage('assets/images/checkicon.png'))),
        //     ),
        //   )
        // ],
      ),
      body: Stack(
        //  crossAxisAlignment: CrossAxisAlignment.start,
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
          _gradientBtn(),
          Container(
              margin: const EdgeInsets.only(top: 100),
              child: StreamBuilder(
                  stream:
                      _manageSessionListBloc!.mangesessionlistblocDataStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(
                            loadingMessage: snapshot.data.message,
                          );

                        case Status.COMPLETED:
                          return _sessionList(snapshot.data.data);

                        case Status.ERROR:
                          return const Text(
                            'Errror msg',
                          );
                          break;
                      }
                    }
                    return Container();
                  }))
        ],
      ),
    );
  }

  Widget _gradientBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      decoration: Palette.buttonGradient,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Home()));
          showAlertDialog(type: 'all', id: '', context: context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Logout From All Sessions",
              style: Palette.whiettext18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sessionList(CommonDataModel commonDataModel) {
    sessionList.clear();
    sessionList.addAll(commonDataModel.data);

    return ListView.builder(
        itemCount: sessionList != null ? sessionList.length : 0,
        primary: true,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          String platfrom = sessionList[index]['platform'];
          String time = sessionList[index]['time'];
          String browser = sessionList[index]['browser'];
          String id = sessionList[index]['id'];

          return Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 10),
            decoration:
                BoxDecoration(color: kThemeColorLightGrey.withOpacity(0.2)),
            child: Row(
              children: [
                platfrom == 'Windows'
                    ? Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/chromeicon.png'))),
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/phone.png'))),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$platfrom',
                        style: Palette.greyDarktext12,
                      ),
                      Row(
                        children: [
                          Text(
                            '$browser',
                            style: Palette.themText11,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$time',
                            style: Palette.blackText12,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showAlertDialog(type: 'single', id: id, context: context);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logouticon.png'))),
                  ),
                ),
              ],
            ),
          );
        });
  }

  showAlertDialog(
      {required String type,
      required String id,
      required BuildContext context}) {
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
        style: GoogleFonts.reemKufi(
            fontSize: 14.0, color: kBlack, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        setState(() {
          LogoutSessionBloc(type, id, _keyLoader, context);
          Navigator.pop(context, false);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
          //_manageSessionListBloc = ManageSessionListBloc(_keyLoaderget, context);
        });
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
}
