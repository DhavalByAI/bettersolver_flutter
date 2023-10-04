import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewGroup extends StatefulWidget {
  @override
  State<CreateNewGroup> createState() => _CreateNewGroupState();
}

class _CreateNewGroupState extends State<CreateNewGroup> {
  TextEditingController groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhite,
        title: Text(
          'ACTIVITIES',
          style: Palette.greytext20B,
        ),
        actions: [
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/checkicon.png'))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: Palette.loginGradient,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
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
                        margin: EdgeInsets.only(top: 10),
                        decoration: Palette.RoundGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage('assets/images/pic.png'))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _groupTextfield()
                    ],
                  ),
                ],
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

  Widget _groupTextfield() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(),
      width: 180,
      child: TextField(
        controller: groupNameController,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        decoration: new InputDecoration(
          hintText: "Group Name",

          // labelText: "Email",
          labelStyle: GoogleFonts.roboto(color: const Color(0xFF424242)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            // borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            // borderRadius: BorderRadius.circular(30.0),
          ),
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

                  // Container(
                  //     alignment: Alignment.centerRight,
                  //     margin: EdgeInsets.only(right: 10),
                  //     child: Icon(
                  //       Icons.arrow_right_outlined,
                  //       color: kThemeColorBlue,
                  //     ))
                ],
              ),
            ),
          );
        });
  }
}
