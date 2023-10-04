import 'package:bettersolver/screen/viewprofile/viewprofile_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowingScreen extends StatefulWidget {
  String title;
  List followingData;

  FollowingScreen({required this.followingData, required this.title});
  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  // FollowingBloc? _followingBloc;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  List followingList = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhite,
        title: Text(
          widget.title,
          style: Palette.greytext20B,
        ),
      ),
      body: Stack(
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
            margin: const EdgeInsets.only(left: 15, top: 40, right: 15),
            child: Container(
              width: MediaQuery.of(context).size.width / 1,
              height: 50,
              decoration: Palette.cardShapGradient,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(25))),
                  child: TextField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "SEARCH HERE",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintStyle: Palette.greytext12,
                      // labelText: "Email",
                      labelStyle: GoogleFonts.roboto(color: Color(0xFF424242)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 100),
              child: _followingList(widget.followingData))
        ],
      ),
    );
  }

  Widget _followingList(List<dynamic> followingList) {
    return ListView.builder(
        itemCount: followingList != null ? followingList.length : 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (Context, index) {
          String profileimage = followingList[index]['avatar'];
          String firstName = followingList[index]['first_name'];
          String lastName = followingList[index]['last_name'];
          String userid = followingList[index]['user_id'];
          // bool is_following =
          //     followingList[index]['is_following'] == "1" ? true : false;
          return Container(
            color: kThemeColorLightGrey.withOpacity(0.2),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewProfileScreen(
                              userviewid: userid,
                            )));
              },
              child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(profileimage),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '$firstName $lastName',
                    style: Palette.greytext15,
                  ),
                  Spacer(),
                  // is_following
                  //     ? Container(
                  //         // margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  //         decoration: Palette.buttonGradient,
                  //         child: InkWell(
                  //           onTap: () {
                  //             // Navigator.push(
                  //             //     context, MaterialPageRoute(builder: (context) => Home()));
                  //             // LoadingDialog.showLoadingDialog(context, _keyLoaderforloder);

                  //             // BlockedBloc(id, 'un-block', _keyLoader, context, "User Un-Blocked");
                  //           },
                  //           child: Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 18, vertical: 8),
                  //             child: Center(
                  //               child: Text(
                  //                 "Following",
                  //                 style: Palette.whiettext8.copyWith(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w600),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : Container(
                  //         // margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  //         decoration: Palette.buttonGradient,
                  //         child: InkWell(
                  //           onTap: () {
                  //             // Navigator.push(
                  //             //     context, MaterialPageRoute(builder: (context) => Home()));
                  //             // LoadingDialog.showLoadingDialog(context, _keyLoaderforloder);

                  //             // BlockedBloc(id, 'un-block', _keyLoader, context, "User Un-Blocked");
                  //           },
                  //           child: Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 18, vertical: 8),
                  //             child: Center(
                  //               child: Text(
                  //                 "Follow",
                  //                 style: Palette.whiettext8.copyWith(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w600),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
