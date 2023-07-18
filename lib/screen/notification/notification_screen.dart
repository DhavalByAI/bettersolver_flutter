import 'package:bettersolver/bloc/notification_bloc.dart';
import 'package:bettersolver/models/notification_model.dart';
import 'package:bettersolver/screen/postView.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../bottom_navigation.dart';

class NotificationBottomScreen extends StatefulWidget {
  const NotificationBottomScreen({super.key});

  @override
  State<NotificationBottomScreen> createState() =>
      _NotificationBottomScreenState();
}

class _NotificationBottomScreenState extends State<NotificationBottomScreen> {
  NotificationBloc? _notificationBloc;

  List notificationList = [];

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    _notificationBloc = NotificationBloc(_keyLoader, context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
        return true;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: kWhite,
          title: Text(
            'NOTIFICATION',
            style: Palette.greytext20B,
          ),
          // actions: [
          //   InkWell(
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => MessageScreen()));
          //     },
          //     child: Container(
          //       height: 20,
          //       width: 20,
          //       margin: const EdgeInsets.only(right: 15),
          //       decoration: const BoxDecoration(
          //           image: DecorationImage(
          //               image: AssetImage('assets/images/chaticonbig.png'))),
          //     ),
          //   )
          // ],
        ),
        body: Stack(
          children: [
            Container(
              height: 20,
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
              margin: const EdgeInsets.only(top: 40),
              child: StreamBuilder(
                  stream: _notificationBloc!.notifcationBlocDataStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(
                            loadingMessage: snapshot.data.message,
                          );

                        case Status.COMPLETED:
                          return _notificationList(snapshot.data.data);

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
            )
          ],
        ),
      ),
    );
  }

  Widget _notificationList(NotificationModel notificationModel) {
    notificationList.clear();
    notificationList.addAll(notificationModel.notifications);

    return ListView.builder(
        itemCount: notificationList != null ? notificationList.length : 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (Context, index) {
          String type = notificationList[index]['type_text'];
          String time = notificationList[index]['time_text_string'];

          var notifier = notificationList[index]['notifier'];

          String username = notifier['username'];
          String profilephoto = notifier['avatar'];

          print('type_text:::::::::::::$type');

          return InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostView(
                            postId: notificationList[index]['post_id'],
                          )));
            },
            child: Container(
              color: kThemeColorLightGrey.withOpacity(0.2),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: CachedNetworkImageProvider(profilephoto),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              username,
                              style: Palette.blacktext14,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                type,
                                style: Palette.greytext14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/timeicon.png'))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            time,
                            style: Palette.greytext12,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
