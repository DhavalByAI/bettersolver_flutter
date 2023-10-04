import 'package:bettersolver/bloc/userdetail_bloc.dart';
import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/screen/profile/categories_screen.dart';
import 'package:bettersolver/screen/profile/followers_screen.dart';
import 'package:bettersolver/screen/profile/following_screen.dart';
import 'package:bettersolver/screen/profile/photo_screen.dart';
import 'package:bettersolver/screen/profile/profile_bio.dart';
import 'package:bettersolver/screen/profile/save_post_list.dart';
import 'package:bettersolver/screen/profile/timeline_screen.dart';
import 'package:bettersolver/screen/profile/video_screen.dart';
import 'package:bettersolver/screen/setting/seting_screen.dart';
import 'package:bettersolver/screen/your_activity/activity_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserDetailBloc? _userDetailBloc;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List userdataList = [];
  shared(
      {required String userName,
      String? fName,
      String? lName,
      required String avtarURL,
      required String coverURL}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userName', userName);
    pref.setString('fullName', "$fName $lName");
    pref.setString('avtarURL', avtarURL);
    pref.setString('coverURL', coverURL);
    print(pref.getString('avtarURL'));
  }

  @override
  void initState() {
    super.initState();
    _userDetailBloc = UserDetailBloc(_keyLoader, context);
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
      //   leading: Container(
      //       alignment: Alignment.center,
      //       child: InkWell(
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => BioProfile()));
      //         },
      //         child: GradientText(
      //           'Edit',
      //           style: Palette.themText15,
      //           colors: [kThemeColorBlue, kThemeColorGreen],
      //         ),
      //       )),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           _showMoreBottomSheet();
      //         },
      //         icon: Icon(Icons.segment_outlined))
      //   ],
      // ),
      body: StreamBuilder(
        stream: _userDetailBloc!.userdetailblocDataStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(
                  loadingMessage: snapshot.data.message,
                );
                break;
              case Status.COMPLETED:
                return _detail(snapshot.data.data);
                break;
              case Status.ERROR:
                return Container(
                  child: const Text(
                    'Errror msg',
                  ),
                );
                break;
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
    String follower = userDetailModel.user_data['followers_number'];
    String following = userDetailModel.user_data['following_number'];
    String postCount = userDetailModel.user_data['post_count'];
    String firstname = userDetailModel.user_data['first_name'];
    String lastname = userDetailModel.user_data['last_name'];
    String username = userDetailModel.user_data['username'];
    List followingData = userDetailModel.user_data['following'];
    List followerData = userDetailModel.user_data['followers'];
    String uid = userDetailModel.user_data['user_id'];
    shared(
        userName: username,
        avtarURL: profileimage,
        coverURL: coverimage,
        fName: firstname,
        lName: lastname);
    return SingleChildScrollView(
      //physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          // Container(
          //   height: 300,
          //   decoration: Palette.loginGradient,
          //   child: Stack(
          //     children: [
          //       Container(
          //         height: 280,
          //         decoration: BoxDecoration(
          //             color: kWhite,
          //             borderRadius: BorderRadius.only(
          //                 bottomRight: Radius.circular(30.0),
          //                 bottomLeft: Radius.circular(30.0))),
          //       ),
          //
          //       // Container(
          //       //   height: 200,
          //       //   width: MediaQuery.of(context).size.width,
          //       //   decoration: BoxDecoration(
          //       //     image: DecorationImage(
          //       //       fit: BoxFit.fill,
          //       //       image: AssetImage('assets/images/pic.png')
          //       //     )
          //       //   ),
          //       // ),
          //
          //       Column(
          //         children: [
          //           SizedBox(height: 30),
          //           Container(
          //             height: 150,
          //             width: 150,
          //             decoration: Palette.RoundGradient,
          //             child: Padding(
          //               padding: const EdgeInsets.all(2),
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(80),
          //                     image: DecorationImage(
          //                         fit: BoxFit.fill,
          //                         image:
          //                         CachedNetworkImageProvider(profileimage))),
          //               ),
          //             ),
          //           ),
          //           SizedBox(
          //             height: 30,
          //           ),
          //           Container(
          //             margin: EdgeInsets.only(left: 20, right: 20),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 InkWell(
          //                   onTap: () {
          //                     Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) =>
          //                                 FollowersScreen()));
          //                   },
          //                   child: Column(
          //                     children: [
          //                       Text(
          //                         '$follower',
          //                         style: Palette.greytext20B,
          //                       ),
          //                       Text(
          //                         'Followers',
          //                         style: Palette.greytext16B,
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 // SizedBox(width: 50,),
          //                 Divider(
          //                   thickness: 2,
          //                   color: kBlack,
          //                 ),
          //                 InkWell(
          //                   onTap: () {
          //                     Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) =>
          //                                 FollowingScreen()));
          //                   },
          //                   child: Column(
          //                     children: [
          //                       Text(
          //                         '$following',
          //                         style: Palette.greytext20B,
          //                       ),
          //                       Text(
          //                         'Following',
          //                         style: Palette.greytext16B,
          //                       ),
          //                     ],
          //                   ),
          //                 )
          //               ],
          //             ),
          //           )
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            height: 420,
            decoration: Palette.loginGradient,
            child: Stack(
              children: [
                Container(
                  height: 400,
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
                  child: Stack(
                    children: [
                      Container(
                        height: 110,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black87, Colors.transparent])),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 0, right: 0, top: 25),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BioProfile()));
                                    },
                                    child: Text(
                                      'Edit',
                                      style: Palette.whitetext18,
                                    )),
                              ),
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                //margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  'PROFILE',
                                  style: Palette.whitetext20,
                                )),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                alignment: Alignment.topRight,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SettingScreen()));
                                      //_showMoreBottomSheet();
                                    },
                                    child: const Icon(
                                      Icons.settings,
                                      color: kWhite,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
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
                      // SizedBox(height: 10,),
                      // Container(
                      //   margin: EdgeInsets.only(left: 15,right: 15),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Container(
                      //         width: 150,
                      //         height: 40,
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
                      //               child: Center(
                      //                 // margin: EdgeInsets.only(left: 15),
                      //                 // alignment: Alignment.centerLeft,
                      //                   child: Text(
                      //                     'FOLLOWING',
                      //                     style: Palette.darkBuleText14B,
                      //                   ))
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 150,
                      //         height: 40,
                      //         decoration: Palette.cardShapGradient,
                      //         child: Container(
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.only(
                      //                     topLeft: Radius.circular(30),
                      //                     bottomLeft: Radius.circular(30),
                      //                     bottomRight: Radius.circular(25))),
                      //             child: Center(
                      //               // margin: EdgeInsets.only(left: 15),
                      //               // alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   'MESSAGE',
                      //                   style: Palette.whiteText15,
                      //                 ))
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => FollowersScreen(
                                //               uid: _uid,
                                //             )));
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
                                      userid: uid,
                                    )));
                      },
                      child: _textDesign('MY TIMELINE')),
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
                      child: _textDesign('CATEGORIES')),
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
                    child: _textDesign('PHOTOS'),
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
                    child: _textDesign('VIDEOS'),
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
                                image:
                                    AssetImage('assets/images/saveicon.png'))),
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
                                builder: (context) =>
                                    const SavePostListScreen()));
                      },
                      child: _textDesign('SAVED POSTS')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }

  void _showMoreBottomSheet() {
    showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                width: 60,
                height: 5,
                decoration: Palette.buttonGradient,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
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
                                            'assets/images/settingicon.png'))),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingScreen()));
                              },
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
                                        'SETTINGS',
                                        style: Palette.greytext12,
                                      ))),
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
                                            'assets/images/avctivity.png'))),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 50,
                          decoration: Palette.cardShapGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ActivityScreen()));
                              },
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
                                        'YOUR ACTIVITY',
                                        style: Palette.greytext12,
                                      ))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _textDesign(String text) {
    return Container(
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
                  text,
                  style: Palette.greytext12,
                ))),
      ),
    );
  }
}
