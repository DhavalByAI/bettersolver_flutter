import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';

class CreateNewChat extends StatefulWidget {
  @override
  State<CreateNewChat> createState() => _CreateNewChatState();
}

class _CreateNewChatState extends State<CreateNewChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhite,
        title: Text(
          'CREATE NEW CHAT',
          style: Palette.greytext20B,
        ),
        // actions: [
        //   Container(
        //     height: 20,
        //     width: 20,
        //     margin: EdgeInsets.only(right: 15),
        //     decoration: BoxDecoration(
        //         image: DecorationImage(
        //             image: AssetImage('assets/images/chaticonbig.png'))),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(
              height: 30,
            ),
            _userList()
          ],
        ),
      ),
    );
  }

  Widget _userList() {
    return ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (Context, index) {
          return Container(
            color: kThemeColorLightGrey.withOpacity(0.2),
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProfileScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/photo.png'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Darrell Steward',
                      style: Palette.greytext15,
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_right_outlined,
                        color: kThemeColorBlue,
                      ))
                ],
              ),
            ),
          );
        });
  }
}
