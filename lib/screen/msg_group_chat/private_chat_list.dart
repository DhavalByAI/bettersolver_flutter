import 'package:bettersolver/bloc/message_bloc.dart';
import 'package:bettersolver/models/message_model.dart';
import 'package:bettersolver/screen/msg_group_chat/chat_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PrivateChat extends StatefulWidget {
  @override
  State<PrivateChat> createState() => _PrivateChatState();
}

class _PrivateChatState extends State<PrivateChat> {
  MessageBloc? _messageBloc;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();

  List privateChatList = [];

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
    privateChatList.clear();
    privateChatList.addAll(messageModel.users);
    return ListView.builder(
        itemCount: privateChatList != null ? privateChatList.length : 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (Context, index) {
          String image = privateChatList[index]['avatar'];
          String name = privateChatList[index]['name'];
          String lastSeen = privateChatList[index]['lastseen_time_text'];
          String userId = privateChatList[index]['user_id'];
          return Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                image: privateChatList[index]['avatar'],
                                name: privateChatList[index]['name'],
                                lastSeen: lastSeen,
                                userID: userId,
                              )));
                },
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      margin:
                          const EdgeInsets.only(left: 15, top: 7, bottom: 7),
                      decoration: Palette.RoundGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(image),
                        ),
                      ),
                    ),
                    const SizedBox(
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
              ),
              Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                child: const Divider(
                  thickness: 0.7,
                ),
              )
            ],
          );
        });
  }
}
