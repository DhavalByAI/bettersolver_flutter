import 'dart:convert';

import 'package:bettersolver/bloc/notification_setting_bloc.dart';
import 'package:bettersolver/models/notification_setting_model.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationSettingBloc? _notificationSettingBloc;

  final GlobalKey<State> _keyLoaderget = GlobalKey<State>();

  var data;

  bool reacted = false;
  bool comment = false;
  bool shared = false;
  bool followed = false;
  bool visited = false;
  bool mentioned = false;
  bool joined = false;
  bool timeline = false;
  bool remember = false;

  final int _postReact = 0;

  var _reacted = '0';
  var _comment = '0';
  var _shared = '0';
  var _followed = '0';
  var _visited = '0';
  var _mentioned = '0';
  var _joined = '0';
  var _timeline = '0';
  var _remember = '0';

  var temp_i = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationSettingBloc = NotificationSettingBloc(_keyLoaderget, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        title: Text(
          'NOTIFICATION SETTING',
          style: Palette.greytext20B,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => SettingScreen()));
              EasyLoading.show();
              print('reacted ---- $_reacted');
              print('comment ---- $_comment');
              print('shared ----  $_shared');
              print('followed ----$_followed');
              print('visited ---- $_visited');
              print('mentioned -- $_mentioned');
              print('joined ----  $_joined');
              print('timeline ----$_timeline');
              print('remember ----$_remember');

              SharedPreferences pref = await SharedPreferences.getInstance();
              String? s = pref.getString('s');
              String? userid = pref.getString('userid');

              final requestBody = {
                "user_id": userid,
                "s": s,
                "e_liked": _reacted,
                "e_shared": _shared,
                "e_wondered": '1',
                "e_commented": _comment,
                "e_followed": _followed,
                "e_accepted": _remember,
                "e_mentioned": _mentioned,
                "e_joined_group": _joined,
                "e_liked_page": '1',
                "e_visited": _visited,
                "e_profile_wall_post": _timeline
              };

              final response = await ApiProvider().httpMethodWithoutToken(
                'post',
                'demo2/app_api.php?application=phone&type=set_notifications_settings',
                requestBody,
              );
              print(response);
              // var data = json.decode(response.);
              if (response['api_status'] == "200") {
                EasyLoading.showSuccess("Successfully Updated");
              } else {
                EasyLoading.showError("Something Went Wrong");
              }
              Get.back();
            },
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(right: 5, top: 5),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/checkicon.png'))),
            ),
          )
        ],
      ),
      body: Column(
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
          StreamBuilder(
              stream:
                  _notificationSettingBloc!.notificationsettingblocDataStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Center(
                        child: Loading(
                          loadingMessage: snapshot.data.message,
                        ),
                      );
                    case Status.COMPLETED:
                      print(temp_i);
                      temp_i == 0 ? updateValues(snapshot.data.data) : null;
                      return _detail(snapshot.data.data);
                    case Status.ERROR:
                      return const Text(
                        'Errror msg',
                      );
                  }
                }
                return Container();
              }),
        ],
      ),
    );
  }

  updateValues(NotificationSettingModel notificationSettingModel) {
    if (notificationSettingModel.settings['data']['e_liked'] == 1) {
      reacted = true;
      _reacted = '1';
    }
    if (notificationSettingModel.settings['data']['e_commented'] == 1) {
      comment = true;
      _comment = '1';
    }
    if (notificationSettingModel.settings['data']['e_shared'] == 1) {
      shared = true;
      _shared = '1';
    }

    if (notificationSettingModel.settings['data']['e_followed'] == 1) {
      followed = true;
      _followed = '1';
    }

    if (notificationSettingModel.settings['data']['e_visited'] == 1) {
      visited = true;
      _visited = '1';
    }

    if (notificationSettingModel.settings['data']['e_mentioned'] == 1) {
      mentioned = true;
      _mentioned = '1';
    }

    if (notificationSettingModel.settings['data']['e_joined_group'] == 1) {
      joined = true;
      _joined = '1';
    }

    if (notificationSettingModel.settings['data']['e_profile_wall_post'] == 1) {
      timeline = true;
      _timeline = '1';
    }

    if (notificationSettingModel.settings['data']['e_accepted'] == 1) {
      remember = true;
      _remember = '1';
    }
    temp_i++;
  }

  Widget _detail(NotificationSettingModel notificationSettingModel) {
    // var  _data = notificationSettingModel.settings['data'];
    //
    //  _reacted = notificationSettingModel.settings['data']['e_react'].toString();
    //  _comment = notificationSettingModel.settings['data']['e_commented'].toString();
    // _shared =   notificationSettingModel.settings['data']['e_shared'].toString();
    //  _followed =  notificationSettingModel.settings['data']['e_followed'].toString();
    //  _visited =  notificationSettingModel.settings['data']['e_visited'].toString();
    // _mentioned =  notificationSettingModel.settings['data']['e_mentioned'].toString();
    //  _joined =  notificationSettingModel.settings['data']['e_joined_group'].toString();
    // _timeline =  notificationSettingModel.settings['data']['e_profile_wall_post'].toString();
    //  _remember =  notificationSettingModel.settings['data']['e_memory'].toString();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          CheckboxListTile(
            title: Text(
              'Someone reacted to my posts',
              style: Palette.greytext14,
            ),
            value: reacted,
            selected: reacted,
            onChanged: (value) {
              setState(() {
                reacted = !reacted;
                if (reacted == true) {
                  _reacted = '1';
                } else {
                  _reacted = '0';
                }
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              'Someone commented on my posts',
              style: Palette.greytext14,
            ),
            value: comment,
            onChanged: (value) {
              setState(() {
                comment = value!;
                if (comment) {
                  _comment = '1';
                } else {
                  _comment = '0';
                }
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              'Someone reshared my post on their timeline',
              style: Palette.greytext14,
            ),
            value: shared,
            onChanged: (value) {
              setState(() {
                shared = value!;
                if (shared) {
                  _shared = '1';
                } else {
                  _shared = '0';
                }
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              'Someone followed me',
              style: Palette.greytext14,
            ),
            value: followed,
            onChanged: (value) {
              setState(() {
                followed = value!;
                if (followed) {
                  _followed = '1';
                } else {
                  _followed = '0';
                }
              });
            },
          ),
          // CheckboxListTile(
          //   title: Text(
          //     'Someone visited my profile',
          //     style: Palette.greytext14,
          //   ),
          //   value: visited,
          //   onChanged: (value) {
          //     setState(() {
          //       visited = value!;
          //       if (visited) {
          //         _visited = '1';
          //       } else {
          //         _visited = '0';
          //       }
          //     });
          //   },
          // ),
          CheckboxListTile(
            title: Text(
              'Someone mentioned me',
              style: Palette.greytext14,
            ),
            value: mentioned,
            onChanged: (value) {
              setState(() {
                mentioned = value!;
                if (mentioned) {
                  _mentioned = '1';
                } else {
                  _mentioned = '0';
                }
              });
            },
          ),
          // CheckboxListTile(
          //   title: Text(
          //     'Someone joined my groups',
          //     style: Palette.greytext14,
          //   ),
          //   value: joined,
          //   onChanged: (value) {
          //     setState(() {
          //       joined = value!;
          //       if (joined) {
          //         _joined = '1';
          //       } else {
          //         _joined = '0';
          //       }
          //     });
          //   },
          // ),
          // CheckboxListTile(
          //   title: Text(
          //     'Someone posted on my timeline',
          //     style: Palette.greytext14,
          //   ),
          //   value: timeline,
          //   onChanged: (value) {
          //     setState(() {
          //       timeline = value!;
          //       if (timeline) {
          //         _timeline = '1';
          //       } else {
          //         _timeline = '0';
          //       }
          //     });
          //   },
          // ),
          CheckboxListTile(
            title: Text(
              'You have remembrance on this day',
              style: Palette.greytext14,
            ),
            value: remember,
            onChanged: (value) {
              setState(() {
                remember = value!;
                if (remember) {
                  _remember = '1';
                } else {
                  _remember = '0';
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
