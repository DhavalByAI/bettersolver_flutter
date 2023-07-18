import 'dart:convert';

import 'package:bettersolver/bloc/privacy_get_bloc.dart';
import 'package:bettersolver/bloc/privacy_update_bloc.dart';
import 'package:bettersolver/models/privacy_get_model.dart';
import 'package:bettersolver/screen/setting/security/security_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  PrivacyGetBloc? _privacyGetBloc;

//  PrivacyUpdateBloc _privacyUpdateBloc;

  String _followMe = '';

  List followmeList = [];
  var followMe = '0';

  String _messagewMe = '';
  var messagewMe = '0';
  List messageList = [];

  String _myFollowers = '';

  var myFollowers = '0';
  List myFollowersList = [];

  String _myTimeline = '';

  var myTimeline;

  List myTimelineList = ['Everyone', 'People I follow', 'No one'];

  String _mydob = '';

  var mydob = '0';
  List mydobList = ['Everyone', 'People I follow', 'Nobody'];

  String _visitProfile = '';

  var visitProfile = '0';
  List visitProfileList = [];

  String _myactivities = '';

  var myactivities = '0';
  List myactivitiesList = [];

  String _myStatus = '';
  var myStatus = '0';
  List myStatusList = [];

  String _livePublic = '';
  var livePublic = '0';
  List livePublicList = ['yes', 'No'];

  String _search = '';
  var search = '0';
  List searchList = ['yes', 'No'];

  final GlobalKey<State> keyLoaderget = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderforloder = GlobalKey<State>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _privacyGetBloc = PrivacyGetBloc(keyLoaderget, context);
    followmeJson();
    messagemeJson();
    myfollowersJson();
    visitprofileJson();
    myActivitiesJson();
    statusJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        title: Text(
          'PRIVACY',
          style: Palette.greytext20B,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              if (_followMe.isEmpty) {
                _followMe = followMe;
                // print('myTimeline-----if----------$followMe');
              } else {
                _followMe;
                // print('myTimeline-----else----------$_followMe');
              }

              print('_followMe       $_followMe');

              if (_messagewMe.isEmpty) {
                _messagewMe = messagewMe;
                //  print('_messagewMe-----if----------$messagewMe');
              } else {
                _messagewMe;
                // print('_messagewMe-----else----------$_messagewMe');
              }
              print('_messagewMe       $_messagewMe');

              if (_myFollowers.isEmpty) {
                _myFollowers = myFollowers;
                //  print('_myFollowers-----if----------$_myFollowers');
              } else {
                _myFollowers;
                //  print('_myFollowers-----else----------$_myFollowers');
              }
              print('_myFollowers       $_myFollowers');

              if (_myTimeline.isEmpty) {
                if (myTimeline.contains('Everyone')) {
                  _myTimeline = 'everyone';
                } else if (myTimeline.contains('People I follow')) {
                  _myTimeline = 'ifollow';
                } else {
                  _myTimeline = 'nobody';
                  //  print('_myFollowers-----if----------$_myTimeline');
                }
              } else {
                _myTimeline;
                //  print('_myFollowers-----else----------$_myTimeline');
              }
              print('_myTimeline       $_myTimeline');

              if (_mydob.isEmpty) {
                _mydob = mydob;
                //   print('_mydob-----if----------$_mydob');
              } else {
                _mydob;
                //   print('_mydob-----else----------$_mydob');
              }
              print('_mydob       $_mydob');

              if (_visitProfile.isEmpty) {
                _visitProfile = visitProfile;
                //     print('_visitProfile-----if----------$_visitProfile');
              } else {
                _visitProfile;
                //  print('_visitProfile-----else----------$_visitProfile');
              }
              print('_visitProfile       $_visitProfile');

              if (_myactivities.isEmpty) {
                _myactivities = myactivities;
                // print('_myactivities-----if----------$_myactivities');
              } else {
                _myactivities;
                //  print('_myactivities-----else----------$_myactivities');
              }
              print('_myactivities       $_myactivities');

              if (_myStatus.isEmpty) {
                _myStatus = myStatus;
                //  print('_myStatus-----if----------$_myStatus');
              } else {
                _myStatus;
                //  print('_myStatus-----else----------$_myStatus');
              }
              print('_myStatus       $_myStatus');

              if (_livePublic.isEmpty) {
                _livePublic = livePublic;
                //   print('_livePublic-----if----------$_livePublic');
              } else {
                _livePublic;
                //  print('_livePublic-----else----------$_livePublic');
              }
              print('_livePublic       $_livePublic');

              if (_search.isEmpty) {
                _search = livePublic;
                //   print('_search-----if----------$_search');
              } else {
                _search;
                //  print('_search-----else----------$_search');
              }
              print('_search       $_search');

              LoadingDialog.showLoadingDialog(context, _keyLoaderforloder);

              PrivacyUpdateBloc(
                  _followMe,
                  _messagewMe,
                  _myFollowers,
                  _myTimeline,
                  _mydob,
                  _visitProfile,
                  _myactivities,
                  _myStatus,
                  _livePublic,
                  _search,
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
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: SingleChildScrollView(
                child: StreamBuilder(
              stream: _privacyGetBloc!.privacygetblocDataStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Loading(
                          loadingMessage: snapshot.data.message,
                        ),
                      );

                    case Status.COMPLETED:
                      return _detail(snapshot.data.data);

                    case Status.ERROR:
                      return Container(
                        child: const Text(
                          'Errror msg',
                        ),
                      );
                  }
                }
                return Container();
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _detail(PrivacyGetModel privacyGetModel) {
    followMe = privacyGetModel.privacydata['follow_privacy'];
    messagewMe = privacyGetModel.privacydata['message_privacy'];
    myFollowers = privacyGetModel.privacydata['friend_privacy'];
    myTimeline = privacyGetModel.privacydata['post_privacy'];
    mydob = privacyGetModel.privacydata['birth_privacy'];
    visitProfile = privacyGetModel.privacydata['visit_privacy'];
    myactivities = privacyGetModel.privacydata['show_activities_privacy'];
    myStatus = privacyGetModel.privacydata['status'];
    livePublic = privacyGetModel.privacydata['share_my_location'];
    search = privacyGetModel.privacydata['share_my_data'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textCommon('Who Can Follow Me?'),
        _followMeDropDown(),
        _textCommon('Who Can Message Me?'),
        _messageMeDropDown(),
        _textCommon('Who Can See My Followers?'),
        _myFolowersDropDown(),
        _textCommon('Who Can Post On My Timeline?'),
        _myTimelineDropDown(),
        _textCommon('Who Can See My Birthdate?'),
        _mydobDropDown(),
        _textCommon('Send Users a Notification When I Visit Their Profile?'),
        _visitprofileDropDown(),
        _textCommon('Show My Activities?'),
        _myActivitiesDropDown(),
        _textCommon('Status'),
        _myStatusDropDown(),
        _textCommon('Share Where I Live With Public?'),
        _livePublicDropDown(),
        _textCommon('Allow Search Engines To Index My Profile And Posts?'),
        _searchDropDown(),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _textCommon(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 15),
      child: GradientText(
        text,
        style: Palette.greytext12,
        colors: [kThemeColorBlue, kThemeColorGreen],
      ),
    );
  }

  Widget _followMeDropDown() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.reemKufi(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          value: followMe,
          hint: Text(
            'Everyone',
            style:
                GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          items: followmeList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item['name'],
                style: Palette.greytext14,
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            // prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              _followMe = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _messageMeDropDown() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.reemKufi(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          value: messagewMe,
          hint: Text(
            'Everyone',
            style:
                GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          items: messageList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item['name'],
                style: Palette.greytext14,
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            // prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              _messagewMe = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _myFolowersDropDown() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.reemKufi(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          value: myFollowers,
          hint: Text(
            'Everyone',
            style:
                GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          items: myFollowersList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item['name'],
                style: Palette.greytext14,
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            // prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              _myFollowers = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _myTimelineDropDown() {
    if (myTimeline.contains('everyone')) {
      myTimeline = 'Everyone';
    } else if (myTimeline.contains('ifollow')) {
      myTimeline = 'People I follow';
    } else {
      myTimeline = 'No one';
    }
    print('--$myTimeline');

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.reemKufi(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          value: myTimeline,
          hint: Text(
            'Everyone',
            style:
                GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          items: myTimelineList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item,
                style: Palette.greytext14,
              ),
              value: item,
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            // prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              _myTimeline = newValue.toString();
              if (_myTimeline.contains('Everyone')) {
                _myTimeline = 'everyone';
              } else if (_myTimeline.contains('People I follow')) {
                _myTimeline = 'ifollow';
              } else {
                _myTimeline = 'nobody';
              }
              print('new value::::$_myTimeline');
            });
          },
        ),
      ),
    );
  }

  Widget _mydobDropDown() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.reemKufi(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          value: mydob,
          hint: Text(
            'Everyone',
            style:
                GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          items: messageList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item['name'],
                style: Palette.greytext14,
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            // prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              _mydob = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _visitprofileDropDown() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.reemKufi(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          value: visitProfile,
          hint: Text(
            'yes',
            style:
                GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          items: visitProfileList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item['name'],
                style: Palette.greytext14,
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            // prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              _visitProfile = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _myActivitiesDropDown() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.reemKufi(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          value: myactivities,
          hint: Text(
            'yes',
            style:
                GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          items: myactivitiesList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item['name'],
                style: Palette.greytext14,
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            // prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              _myactivities = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _myStatusDropDown() {
    // if(myStatus.contains('0')){
    //   myStatus = 'Online';
    // }else{
    //   myStatus = 'Offline';
    // }

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.reemKufi(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          value: myStatus,
          hint: Text(
            'online',
            style:
                GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          items: myStatusList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item['name'],
                style: Palette.greytext14,
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            // prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              _myStatus = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _livePublicDropDown() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.reemKufi(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          value: livePublic,
          hint: Text(
            'yes',
            style:
                GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          items: myactivitiesList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item['name'],
                style: Palette.greytext14,
              ),
              value: item['id'],
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            // prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              _livePublic = newValue.toString();
            });
          },
        ),
      ),
    );
  }

  Widget _searchDropDown() {
    // if(search.contains('0')){
    //   search = 'No';
    // }else{
    //   search = 'yes';
    // }

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.reemKufi(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          value: search,
          hint: Text(
            'yes',
            style:
                GoogleFonts.reemKufi(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          items: myactivitiesList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item['name'],
                style: Palette.greytext14,
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            // prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              _search = newValue!;
            });
          },
        ),
      ),
    );
  }

  Future<void> followmeJson() async {
    String response =
        await rootBundle.loadString('assets/jsonfile/followme.json');
    var decode = await json.decode(response);

    setState(() {
      followmeList = decode['followMe'];
    });
    //  print(':::::::::::::::$followmeList');
  }

  Future<void> messagemeJson() async {
    String response =
        await rootBundle.loadString('assets/jsonfile/messageme.json');
    var decode = await json.decode(response);

    setState(() {
      messageList = decode['messageMe'];
    });
    //  print(':::::::::::::::$messageList');
  }

  Future<void> mytimelineJson() async {
    String response =
        await rootBundle.loadString('assets/jsonfile/mytimeline.json');
    var decode = await json.decode(response);

    setState(() {
      myTimelineList = decode['myTimeline'];
    });
    //  print(':::::::::::::::$messageList');
  }

  Future<void> myfollowersJson() async {
    String response =
        await rootBundle.loadString('assets/jsonfile/myfollowers.json');
    var decode = await json.decode(response);

    setState(() {
      myFollowersList = decode['myFollowers'];
    });
//    print(':::::::::::::::$myFollowersList');
  }

  Future<void> visitprofileJson() async {
    String response =
        await rootBundle.loadString('assets/jsonfile/visitprofile.json');
    var decode = await json.decode(response);

    setState(() {
      visitProfileList = decode['visitProfile'];
    });
    //   print(':::::::::::::::$visitProfileList');
  }

  Future<void> myActivitiesJson() async {
    String response =
        await rootBundle.loadString('assets/jsonfile/myactivities.json');
    var decode = await json.decode(response);

    setState(() {
      myactivitiesList = decode['myActivities'];
    });
    print(':::::::::::::::$visitProfileList');
  }

  Future<void> statusJson() async {
    String response =
        await rootBundle.loadString('assets/jsonfile/status.json');
    var decode = await json.decode(response);

    setState(() {
      myStatusList = decode['sataus'];
    });
    print(':::::::::::::::$visitProfileList');
  }
}
