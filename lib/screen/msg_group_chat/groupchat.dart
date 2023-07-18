import 'package:bettersolver/bloc/message_bloc.dart';
import 'package:bettersolver/models/message_model.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../grup_chat_screen.dart';

class GroupChat extends StatefulWidget {
  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  MessageBloc? _messageBloc;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();

  List groupList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageBloc = MessageBloc(_keyLoader, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: StreamBuilder(
            stream: _messageBloc!.messageblocDataStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(
                      loadingMessage: snapshot.data.message,
                    );
                    break;
                  case Status.COMPLETED:
                    return _privatechatList(snapshot.data.data);
                    break;
                  case Status.ERROR:
                    return Container(
                      child: Text(
                        'Errror msg',
                      ),
                    );
                    break;
                }
              }
              return Container();
            }));
  }

  Widget _privatechatList(MessageModel messageModel) {
    groupList.addAll(messageModel.groups);
    return ListView.builder(
        itemCount: groupList != null ? groupList.length : 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (Context, index) {
          String image = groupList[index]['avatar'];
          String name = groupList[index]['group_name'];
          String group_id = groupList[index]['group_id'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GroupChatScreen(
                            image: groupList[index]['avatar'],
                            group_name: groupList[index]['group_name'],
                            group_id: groupList[index]['group_id'],
                          )));
            },
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      margin: EdgeInsets.only(left: 15, top: 7, bottom: 7),
                      decoration: Palette.RoundGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(image),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '$name',
                      style: Palette.greytext15,
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(right: 15),
                    //   child: Column(
                    //     //mainAxisAlignment: MainAxisAlignment.end,
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       Text(
                    //         '23 mins',
                    //         style: Palette.greytext12,
                    //       ),
                    //       SizedBox(
                    //         height: 8,
                    //       ),
                    //       Container(
                    //           height: 25,
                    //           width: 25,
                    //           decoration: Palette.buttonGradient,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(0.9),
                    //             child: Center(
                    //                 child: Text(
                    //                   '2',
                    //                   style: Palette.blackTextDark12,
                    //                 )),
                    //           ))
                    //     ],
                    //   ),
                    // )
                  ],
                ),
                Divider(
                  thickness: 2,
                )
              ],
            ),
          );
        });
  }
}
