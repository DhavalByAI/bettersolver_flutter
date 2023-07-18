import 'package:bettersolver/bloc/viewprofile_bloc.dart';
import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/screen/msg_group_chat/chat_screen.dart';
import 'package:bettersolver/screen/profile/categories_screen.dart';
import 'package:bettersolver/screen/profile/following_screen.dart';
import 'package:bettersolver/screen/profile/photo_screen.dart';
import 'package:bettersolver/screen/profile/timeline_screen.dart';
import 'package:bettersolver/screen/profile/video_screen.dart';
import 'package:bettersolver/screen/viewprofile/viewProfile_controller.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bloc/blocked_bloc.dart';

class ViewProfileScreen extends StatefulWidget {
  String userviewid;

  ViewProfileScreen({super.key, required this.userviewid});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  ViewProfileBloc? _viewProfileBloc;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final ViewProfileController _ = Get.put(ViewProfileController());

  // shared(
  //     {required String userName,
  //     String? fName,
  //     String? lName,
  //     required String avtarURL,
  //     required String coverURL}) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('userName', userName);
  //   pref.setString('fullName', "$fName $lName");
  //   pref.setString('avtarURL', avtarURL);
  //   pref.setString('coverURL', coverURL);

  //   print(pref.getString('avtarURL'));
  // }

  @override
  void initState() {
    super.initState();

    _viewProfileBloc = ViewProfileBloc(widget.userviewid, _keyLoader, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: kWhite,
      //   title: Text(
      //     'PROFILE',
      //     style: Palette.greytext20B,
      //   ),
      //   centerTitle: true,
      //   // leading: Container(
      //   //     alignment: Alignment.center,
      //   //     child: InkWell(
      //   //       onTap: () {
      //   //         Navigator.push(context,
      //   //             MaterialPageRoute(builder: (context) => BioProfile()));
      //   //       },
      //   //       child: GradientText(
      //   //         'Edit',
      //   //         style: Palette.themText15,
      //   //         colors: [kThemeColorBlue, kThemeColorGreen],
      //   //       ),
      //   //     )),
      //   // actions: [
      //   //   IconButton(
      //   //       onPressed: () {
      //   //         _showMoreBottomSheet();
      //   //       },
      //   //       icon: Icon(Icons.segment_outlined))
      //   // ],
      // ),

      body: StreamBuilder(
        stream: _viewProfileBloc!.viewProfileblocDataStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(
                  loadingMessage: snapshot.data.message,
                );
              case Status.COMPLETED:
                _.userDetailModel = snapshot.data.data;
                return GetBuilder<ViewProfileController>(
                  initState: (_) {},
                  builder: (_) {
                    return _detail(_.userDetailModel!);
                  },
                );
              case Status.ERROR:
                return const Text('Errror msg');
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _detail(UserDetailModel userDetailModel) {
    String profileimage = userDetailModel.user_data['avatar'];
    String coverimage = userDetailModel.user_data['cover'];
    String username = userDetailModel.user_data['username'];
    String firstname = userDetailModel.user_data['first_name'] ?? '-';
    String lastname = userDetailModel.user_data['last_name'] ?? '-';
    String postCount = userDetailModel.user_data['post_count'];
    String lastseen = userDetailModel.user_data['lastseen_time_text'];
    String follower = userDetailModel.user_data['followers_number'];
    String following = userDetailModel.user_data['following_number'];
    String uid = userDetailModel.user_data['user_id'];
    String isFollowing = userDetailModel.user_data['is_following'];

    List followingData = userDetailModel.user_data['following'];
    List followerData = userDetailModel.user_data['followers'];
    print('==widget.userviewid==${widget.userviewid}');
    print('==_uid.==$uid');
    // shared(
    //     userName: username,
    //     avtarURL: profileimage,
    //     coverURL: coverimage,
    //     fName: firstname,
    //     lName: lastname);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 470,
            decoration: Palette.loginGradient,
            child: Stack(
              children: [
                Container(
                  height: 450,
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0))),
                ),
                Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(coverimage))),
                  child: Container(
                    margin: const EdgeInsets.only(left: 0, right: 0, top: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SettingScreen()));
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_outlined,
                              color: kWhite,
                            )),
                        Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              'PROFILE',
                              style: Palette.whitetext20,
                            )),
                        const Spacer(),
                        _popupmenuForBlock(
                            uID: uid,
                            isBlocked: userDetailModel.user_data['is_blocked'],
                            isReposrted:
                                userDetailModel.user_data['isReported']),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 140,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: Palette.RoundGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: CachedNetworkImageProvider(
                                        profileimage))),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          //alignment: Alignment.bottomCenter,
                          child: Text(
                            '$firstname $lastname',
                            style: Palette.greytext18B,
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          //alignment: Alignment.bottomCenter,
                          child: Text(
                            '@$username',
                            style: Palette.greytext14,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            isFollowing == "1"
                                ? GetBuilder<ViewProfileController>(
                                    initState: (_) {},
                                    builder: (_) {
                                      return InkWell(
                                        onTap: () {
                                          _.doFollow(uid);
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 40,
                                          decoration: Palette.cardShapGradient,
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                    color: kWhite,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    30),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    30),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    25))),
                                                child: Center(
                                                    // margin: EdgeInsets.only(left: 15),
                                                    // alignment: Alignment.centerLeft,
                                                    child: Text(
                                                  'FOLLOWING',
                                                  style:
                                                      Palette.darkBuleText14B,
                                                ))),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : GetBuilder<ViewProfileController>(
                                    initState: (_) {},
                                    builder: (_) {
                                      return InkWell(
                                        onTap: () {
                                          _.doFollow(uid);
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 40,
                                          decoration: Palette.cardShapGradient,
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    30),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    30),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    25))),
                                                child: Center(
                                                    // margin: EdgeInsets.only(left: 15),
                                                    // alignment: Alignment.centerLeft,
                                                    child: Text(
                                                  'FOLLOW',
                                                  style: Palette.whiteText15,
                                                ))),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            InkWell(
                              onTap: () {
                                Get.to(() => ChatScreen(
                                      image: profileimage,
                                      name: '$firstname $lastname',
                                      lastSeen: lastseen,
                                      userID: uid,
                                    ));
                              },
                              child: Container(
                                width: 150,
                                height: 40,
                                decoration: Palette.cardShapGradient,
                                child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(25))),
                                    child: Center(
                                        // margin: EdgeInsets.only(left: 15),
                                        // alignment: Alignment.centerLeft,
                                        child: Text(
                                      'MESSAGE',
                                      style: Palette.whiteText15,
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TimeLineScreen(
                                              userid: widget.userviewid,
                                            )));
                              },
                              child: Column(
                                children: [
                                  Text(
                                    postCount,
                                    style: Palette.greytext20B,
                                  ),
                                  Text(
                                    'Posts',
                                    style: Palette.greytext16B,
                                  ),
                                ],
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FollowingScreen(
                                              followingData: followerData,
                                              title: "FOLLOWERS",
                                            )));
                              },
                              child: Column(
                                children: [
                                  Text(
                                    follower,
                                    style: Palette.greytext20B,
                                  ),
                                  Text(
                                    'Followers',
                                    style: Palette.greytext16B,
                                  ),
                                ],
                              ),
                            ),

                            // VerticalDivider(
                            //   thickness: 2,
                            //   width: 2,
                            //   indent: 20,
                            // ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FollowingScreen(
                                              followingData: followingData,
                                              title: "FOLLOWING",
                                            )));
                              },
                              child: Column(
                                children: [
                                  Text(
                                    following,
                                    style: Palette.greytext20B,
                                  ),
                                  Text(
                                    'Following',
                                    style: Palette.greytext16B,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Row(
              children: [
                Container(
                  decoration: Palette.RoundGradient,
                  height: 50,
                  width: 50,
                  child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(30),
                          // image: const DecorationImage(
                          //     scale: 0.1,
                          //     fit: BoxFit.contain,
                          //     image: AssetImage(
                          //         'assets/images/information.png'))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/information.png',
                            color: Colors.black54,
                            fit: BoxFit.scaleDown,
                            height: 14,
                            width: 14,
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
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
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'USER INFO',
                                    style: Palette.greytext12,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 16,
                                                child: Icon(
                                                  Icons.person_3_rounded,
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(userDetailModel
                                                  .user_data['gender_text'])
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 16,
                                                child: Icon(
                                                  Icons.cake_rounded,
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(userDetailModel
                                                  .user_data['birthday'])
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Row(
                                            children: const [
                                              CircleAvatar(
                                                radius: 16,
                                                child: Icon(
                                                  Icons.place_rounded,
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Flexible(
                                                child: Text('Living in India'),
                                              )
                                            ],
                                          ),
                                        ),
                                        userDetailModel.user_data['address'] !=
                                                ''
                                            ? Flexible(
                                                child: Row(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 16,
                                                      child: Icon(
                                                        Icons
                                                            .location_city_rounded,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                          userDetailModel
                                                                  .user_data[
                                                              'address']),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Flexible(
                                                child: Row(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 16,
                                                      child: Icon(
                                                        Icons
                                                            .business_center_rounded,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(userDetailModel
                                                                .user_data[
                                                            'occupation'] ??
                                                        "Proffesional")
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),

          ///
          Container(
            margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Row(
              children: [
                Container(
                  decoration: Palette.RoundGradient,
                  height: 50,
                  width: 50,
                  child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        // height: 50,
                        // width: 50,

                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/timelineicon.png'))),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TimeLineScreen(
                                    userid: widget.userviewid,
                                  )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
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
                            child: Container(
                                margin: const EdgeInsets.only(left: 15),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'TIMELINE',
                                  style: Palette.greytext12,
                                ))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Row(
              children: [
                Container(
                  decoration: Palette.RoundGradient,
                  height: 50,
                  width: 50,
                  child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        // height: 50,
                        // width: 50,

                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/categoriesicon.png'))),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesScreen(
                                    userid: uid,
                                  )));
                    },
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 1.3,
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
                            child: Container(
                                margin: const EdgeInsets.only(left: 15),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'CATEGORIES',
                                  style: Palette.greytext12,
                                ))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Row(
              children: [
                Container(
                  decoration: Palette.RoundGradient,
                  height: 50,
                  width: 50,
                  child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        // height: 50,
                        // width: 50,

                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/photosicon.png'))),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhotoScreen(
                                    userid: uid,
                                  )));
                    },
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 1.3,
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
                            child: Container(
                                margin: const EdgeInsets.only(left: 15),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'PHOTOS',
                                  style: Palette.greytext12,
                                ))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Row(
              children: [
                Container(
                  decoration: Palette.RoundGradient,
                  height: 50,
                  width: 50,
                  child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        // height: 50,
                        // width: 50,

                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/videosicon.png'))),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoScreen(
                                    userid: uid,
                                  )));
                    },
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 1.3,
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
                            child: Container(
                                margin: const EdgeInsets.only(left: 15),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'VIDEOS',
                                  style: Palette.greytext12,
                                ))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Container(
          //   margin: EdgeInsets.only(left: 15, top: 20, right: 15),
          //   child: Row(
          //     children: [
          //       Container(
          //         decoration: Palette.RoundGradient,
          //         height: 50,
          //         width: 50,
          //         child: Padding(
          //             padding: const EdgeInsets.all(1.0),
          //             child: Container(
          //               // height: 50,
          //               // width: 50,
          //
          //               decoration: BoxDecoration(
          //                   color: kWhite,
          //                   borderRadius: BorderRadius.circular(30),
          //                   image: DecorationImage(
          //                       image: AssetImage(
          //                           'assets/images/saveicon.png'))),
          //             )),
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Container(
          //         width: MediaQuery.of(context).size.width / 1.3,
          //         height: 50,
          //         decoration: Palette.cardShapGradient,
          //         child: Padding(
          //           padding: const EdgeInsets.all(1.0),
          //           child: Container(
          //               decoration: BoxDecoration(
          //                   color: kWhite,
          //                   borderRadius: BorderRadius.only(
          //                       topLeft: Radius.circular(30),
          //                       bottomLeft: Radius.circular(30),
          //                       bottomRight: Radius.circular(25))),
          //               child: Container(
          //                   margin: EdgeInsets.only(left: 15),
          //                   alignment: Alignment.centerLeft,
          //                   child: Text(
          //                     'SAVED POSTS',
          //                     style: Palette.greytext12,
          //                   ))),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          const SizedBox(height: 100)
        ],
      ),
    );
  }

  Widget _popupmenuForBlock(
      {required String uID,
      required bool isBlocked,
      required bool isReposrted}) {
    return PopupMenuButton(
        color: Colors.white,
        shape: Palette.cardShape,
        offset: const Offset(100, 0),
        elevation: 8.0,
        child: Container(
          child: const Icon(
            Icons.report,
            color: Colors.white,
            size: 32,
          ),
        ),
        itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Value1',
                child: InkWell(
                  onTap: () {
                    BlockedBloc(
                        uID, 'block', _keyLoader, context, "User Blocked");
                    Get.back();
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.block_rounded, color: Colors.yellow),
                      const SizedBox(width: 10),
                      Text(isBlocked ? 'Blocked User' : 'Block User'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'Value2',
                child: InkWell(
                  onTap: () {
                    _.userReport(uID);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.report_gmailerrorred_rounded,
                          color: Colors.red),
                      const SizedBox(width: 10),
                      Text(isReposrted ? 'Unreport user' : 'Report User'),
                    ],
                  ),
                ),
              ),
            ]);
  }
}
