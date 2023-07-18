import 'package:bettersolver/screen/msg_group_chat/private_chat_list.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhite,
        title: Text(
          'MESSAGE',
          style: Palette.greytext20B,
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
            DefaultTabController(
                length: 1, // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TabBar(
                        unselectedLabelColor: Colors.black,
                        indicatorColor: kThemeColorBlue,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3.0,
                        tabs: [
                          Tab(
                            child: GradientText(
                              'Private Chat',
                              style: Palette.wihtetext14,
                              colors: const [kThemeColorBlue, kThemeColorGreen],
                            ),
                            //text: 'Private Chat',
                          ),
                          // Tab(
                          //   child: GradientText(
                          //     'Group Chat',
                          //     style: Palette.wihtetext14,
                          //     colors: const [kThemeColorBlue, kThemeColorGreen],
                          //   ),
                          //   //text: 'Private Chat',
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: TabBarView(
                            // children: <Widget>[PrivateChat(), GroupChat()]),
                            children: <Widget>[PrivateChat()]),
                      )
                    ])),
          ]),
    );
  }
}
