import 'package:bettersolver/screen/ListofPosts.dart';
import 'package:bettersolver/screen/home_screen_controller.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'create_post/create_poll_post_screen.dart';
import 'create_post/create_post_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GetHomeScreen extends StatefulWidget {
  const GetHomeScreen({super.key});

  @override
  State<GetHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<GetHomeScreen> {
  List islikeboollist = [];
  List issavepostboollist = [];
  List ispinpostList = [];
  String? profileid;
  String? profilePic;
  ScrollController sc = ScrollController();
  TextEditingController reportTextController = TextEditingController();

  // List categoryList = [];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    shared();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  shared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    profilePic = pref.getString("profileimage");
    profileid = pref.getString('userid');
  }

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    Get.put(HomeScreenController());
    return Scaffold(
      backgroundColor: kWhite,
      // appBar: AppBar(
      //   title: Text(
      //     'better  solver',
      //     style: Palette.whiettext20B.copyWith(fontSize: 26),
      //   ),
      //   toolbarHeight: 65,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   flexibleSpace: Container(
      //     decoration: Palette.loginGradient,
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 15),
      //       child: Row(
      //         children: [
      //           InkWell(
      //               onTap: () {
      //                 Navigator.push(context,
      //                     MaterialPageRoute(builder: (context) => Profile()));
      //               },
      //               child: Image.asset(
      //                 'assets/images/profilewhite.png',
      //                 height: 25,
      //                 width: 25,
      //               )),
      //           const SizedBox(
      //             width: 10,
      //           ),
      //           InkWell(
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => const MessageScreen()));
      //               },
      //               child: Image.asset(
      //                 'assets/images/messagewhite.png',
      //                 height: 25,
      //                 width: 25,
      //               )),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      body: GetBuilder<HomeScreenController>(
        initState: (_) {},
        builder: (_) {
          return Container(
            child: _pagenation(),
          );
        },
      ),
    );
  }

  Widget _pagenation() {
    // _pageno++;
    // posts.addAll(allPostModel!.posts);
    // if (allPostModel.posts.length > 10) {
    //   isLoading = true;
    // }
    // if (allPostModel.posts.length == 0) {
    //   isLoading = false;
    // }

    // if (allPostModel.posts.length > 10) {
    //   isLoading = true;
    // }
    // if (allPostModel.posts.length == 0) {
    //   isLoading = false;
    // }

    return GetBuilder<HomeScreenController>(
      initState: (_) {},
      builder: (_) {
        return _.posts.isNotEmpty
            ? Column(
                children: <Widget>[
                  // Container(
                  //   margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 55,
                  //   decoration: Palette.cardShapGradient,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(0.9),
                  //     child: Container(
                  //       decoration: const BoxDecoration(
                  //         color: kWhite,
                  //         borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(30),
                  //             bottomLeft: Radius.circular(30),
                  //             bottomRight: Radius.circular(25)),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Row(
                  //           children: [
                  //             profilePic != null
                  //                 ? CircleAvatar(
                  //                     radius: 18,
                  //                     backgroundImage:
                  //                         CachedNetworkImageProvider(
                  //                             profilePic!),
                  //                   )
                  //                 : const CircleAvatar(
                  //                     radius: 18,
                  //                     backgroundColor: Colors.white,
                  //                     backgroundImage: AssetImage(
                  //                         "assets/images/profile.png"),
                  //                   ),
                  //             const SizedBox(
                  //               width: 10,
                  //             ),
                  //             Expanded(
                  //                 child: Text(
                  //               'What’s better for us?',
                  //               style: Palette.greytext14,
                  //             )),
                  //             //Expanded(child: _emailEditText(_controller,'What’s better for us?')),
                  //             InkWell(
                  //               onTap: (() {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             CreatePostScreen()));
                  //               }),
                  //               child: Container(
                  //                 height: 40,
                  //                 width: 40,
                  //                 decoration: const BoxDecoration(
                  //                     image: DecorationImage(
                  //                         image: AssetImage(
                  //                             'assets/images/addphoto.png'))),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // AppBar(
                  //   title: Text(
                  //     'better  solver',
                  //     style: Palette.whiettext20B.copyWith(fontSize: 26),
                  //   ),
                  //   toolbarHeight: 65,
                  //   backgroundColor: Colors.transparent,
                  //   elevation: 0,
                  //   flexibleSpace: Container(
                  //     decoration: Palette.loginGradient,
                  //   ),
                  //   actions: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 15),
                  //       child: Row(
                  //         children: [
                  //           InkWell(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) => Profile()));
                  //               },
                  //               child: Image.asset(
                  //                 'assets/images/profilewhite.png',
                  //                 height: 25,
                  //                 width: 25,
                  //               )),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           InkWell(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             const MessageScreen()));
                  //               },
                  //               child: Image.asset(
                  //                 'assets/images/messagewhite.png',
                  //                 height: 25,
                  //                 width: 25,
                  //               )),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),

                  ListOfPosts(
                    isAppbar: true,
                    posts: _.posts,
                    sc: sc,
                    refreshController: refreshController,
                    url:
                        'demo2/app_api.php?application=phone&type=get_post_all',
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(12.0),
                  //   child: GetBuilder<HomeScreenController>(
                  //     initState: (_) {},
                  //     builder: (_) {
                  //       return Opacity(
                  //         opacity: _.isLoading ? 1.0 : 00,
                  //         child: const CircularProgressIndicator(),
                  //       );
                  //     },
                  //   ),
                  // )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  void _showMoreBottomSheet() {
    showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: Palette.cardShapGradient,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreatePostScreen()));
                          });
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
                                  'CREATE POST',
                                  style: Palette.greytext12,
                                ))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    // width: MediaQuery.of(context).size.width / 1.4,
                    height: 50,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: Palette.cardShapGradient,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreatePollPostScreen()));
                          });
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
                                  'CREATE POLL',
                                  style: Palette.greytext12,
                                ))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
