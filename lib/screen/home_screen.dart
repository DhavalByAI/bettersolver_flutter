// import 'dart:convert';

// import 'package:bettersolver/bloc/all_post_bloc.dart';
// import 'package:bettersolver/bloc/delete_post_bloc.dart';
// import 'package:bettersolver/bloc/edit_post_bloc.dart';
// import 'package:bettersolver/bloc/enable_disable_comment_bloc.dart';
// import 'package:bettersolver/bloc/hide_post_bloc.dart';
// import 'package:bettersolver/bloc/liked_bloc.dart';
// import 'package:bettersolver/bloc/pinpost_bloc.dart';
// import 'package:bettersolver/bloc/report_post_bloc.dart';
// import 'package:bettersolver/bloc/saved_post_bloc.dart';
// import 'package:bettersolver/models/all_post_model.dart';
// import 'package:bettersolver/screen/create_post/create_poll_post_screen.dart';
// import 'package:bettersolver/screen/create_post/create_post_screen.dart';
// import 'package:bettersolver/screen/create_post/post_comment_screen.dart';
// import 'package:bettersolver/screen/msg_group_chat/message_screen.dart';
// import 'package:bettersolver/screen/profile/video_play_screen.dart';
// import 'package:bettersolver/screen/search_profile/search_profile_screen.dart';
// import 'package:bettersolver/style/constants.dart';
// import 'package:bettersolver/style/palette.dart';
// import 'package:bettersolver/utils/base_constant.dart';
// import 'package:bettersolver/utils/error.dart';
// import 'package:bettersolver/utils/loading.dart';
// import 'package:bettersolver/utils/response.dart';
// import 'package:bettersolver/widgets/error_dialouge.dart';
// import 'package:bettersolver/widgets/loading_dialogue.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:google_fonts/google_fonts.dart';
// //import 'package:flutter_share_me/flutter_share_me.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
// import 'package:share_plus/share_plus.dart';

// import 'create_post/get_post_comment_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final GlobalKey<State> _keyLoader = GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderlike = GlobalKey<State>();
//   final GlobalKey<State> _keyLoadersavepost = GlobalKey<State>();
//   final GlobalKey<State> _keyLoadercomment = GlobalKey<State>();
//   final GlobalKey<State> _keyError = GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderreport = GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderpin = GlobalKey<State>();

//   ScrollController _scrollController = ScrollController();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController postTextController = TextEditingController();

//   int _pageno = 1;
//   bool firstLoad = true;
//   bool isLoading = false;
//   bool ispage = true;
//   List posts = [];

//   AllpostBloc? _allpostBloc;
//   TextEditingController reportTextController = TextEditingController();

//   var categoryType;
//   List categoryList = [];
//   var user_id;
//   var s;

//   bool liked = false;
//   List islikeboollist = [];

//   bool savepost = false;
//   List issavepostboollist = [];

//   bool pinpoststatus = false;
//   List ispinpostList = [];

//   String? profileid;

//   @override
//   void initState() {
//     super.initState();
//     print("InitState");
//     fetchCatList();
//     _allpostBloc = AllpostBloc(_pageno.toString(), firstLoad);
//     shared();
//     _scrollController.addListener(() {
//       if (_scrollController.position.atEdge) {
//         if (_scrollController.position.pixels == 0) {
//           print('list scroll at top');
//         } else {
//           print('list scroll at bottom');
//           ispage = true;
//           try {
//             firstLoad = false;
//             isLoading = true;
//             _allpostBloc!.fetchallpostData(_pageno.toString(), firstLoad);
//           } catch (e) {
//             debugPrint('Error: $e');
//           }
//         }
//       }
//     });
//     // _scrollController.addListener(() {
//     //   if(_scrollController.offset == _scrollController.position.maxScrollExtent) {
//     //     firstLoad = false;
//     //     isLoading = true;
//     //     _allpostBloc.fetchallpostData(pageno, _keyLoader, context);
//     //   }
//     // });
//   }

//   shared() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     profileid = pref.getString('userid');
//   }

//   @override
//   void dispose() {
//     _allpostBloc!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kWhite,
//       appBar: AppBar(
//         title: Text(
//           'BETTER SOLVER',
//           style: Palette.whiettext20B,
//         ),
//         toolbarHeight: 100,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: Palette.loginGradient,
//         ),
//         actions: [
//           Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   _showMoreBottomSheet();
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 10, top: 7),
//                   height: 40,
//                   width: 40,
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/images/addion.png'))),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => SearchProfileScreen()));
//                 },
//                 child: Container(
//                   height: 40,
//                   width: 40,
//                   margin: const EdgeInsets.only(right: 10),
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/images/searchicon.png'))),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => MessageScreen()));
//                 },
//                 child: Container(
//                   height: 40,
//                   width: 40,
//                   margin: const EdgeInsets.only(right: 10),
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/images/chaticon.png'))),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//       body: Container(
//           //margin: EdgeInsets.only(top: ),
//           child: StreamBuilder(
//               stream: _allpostBloc!.allpostblocDataStream,
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 if (snapshot.hasData) {
//                   switch (snapshot.data.status) {
//                     case Status.LOADING:
//                       return Loading(loadingMessage: snapshot.data.message);
//                       break;
//                     case Status.COMPLETED:
//                       return _pagenation(snapshot.data.data);
//                       break;
//                     case Status.ERROR:
//                       return Errors(
//                         errorMessage: snapshot.data.message,
//                         onRetryPressed: () => _allpostBloc!
//                             .fetchallpostData(_pageno.toString(), firstLoad),
//                       );
//                       break;
//                   }
//                 }
//                 return Container();
//               })),
//     );
//   }

//   Widget _pagenation(AllPostModel? allPostModel) {
//     _pageno++;
//     posts.addAll(allPostModel!.posts);
//     if (allPostModel.posts.length > 10) {
//       isLoading = true;
//     }
//     if (allPostModel.posts.length == 0) {
//       isLoading = false;
//     }

//     // if (allPostModel.posts.length > 10) {
//     //   isLoading = true;
//     // }
//     // if (allPostModel.posts.length == 0) {
//     //   isLoading = false;
//     // }
//     return posts.length != 0
//         ? SingleChildScrollView(
//             controller: _scrollController,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
//                   width: MediaQuery.of(context).size.width,
//                   height: 55,
//                   decoration: Palette.cardShapGradient,
//                   child: Padding(
//                     padding: const EdgeInsets.all(0.9),
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         color: kWhite,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             bottomLeft: Radius.circular(30),
//                             bottomRight: Radius.circular(25)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 18,
//                               backgroundImage: CachedNetworkImageProvider(
//                                   currUser!.user_data['avatar']),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                                 child: Text(
//                               'What’s better for us?',
//                               style: Palette.greytext14,
//                             )),
//                             //Expanded(child: _emailEditText(_controller,'What’s better for us?')),
//                             Container(
//                               height: 40,
//                               width: 40,
//                               decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage(
//                                           'assets/images/addphoto.png'))),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 _listpost(),
//                 _buildProgressIndicator(),
//               ],
//             ),
//           )
//         : const Center(
//             child: Text('Data not Found'),
//           );
//   }

//   Widget _listpost() {
//     return StreamBuilder<Object>(
//         stream: null,
//         builder: (context, snapshot) {
//           return ListView.builder(
//               // controller: _scrollController,
//               itemCount: posts != null ? posts.length : 0,
//               shrinkWrap: true,
//               primary: false,
//               itemBuilder: (Context, index) {
//                 String postid = posts[index]['post_id'];
//                 String posteduserid = posts[index]['user_id'];
//                 String username = posts[index]['publisher']['username'];
//                 String profileimage = posts[index]['publisher']['avatar'];
//                 String fname = posts[index]['publisher']['first_name'] ?? '-';
//                 String lname = posts[index]['publisher']['last_name'] ?? '-';
//                 String posttime = posts[index]['post_time'];

//                 String commentstatus = posts[index]['comments_status'];
//                 bool iscommentstatus = false;

//                 if (commentstatus.contains("1")) {
//                   iscommentstatus = true;
//                 } else {
//                   iscommentstatus = false;
//                 }
//                 //  print('Comment_statu-------$commentstatus');
//                 String comment = posts[index]['post_comments'];
//                 print("no.of comment :${comment}");
//                 String title = posts[index]['title'] ?? '-';
//                 String postText = posts[index]['postText'] ?? '-';
//                 String group_id = posts[index]['group_id'];

//                 savepost = posts[index]['is_post_saved'];
//                 liked = posts[index]['reaction']['is_reacted'];
//                 int likecount = posts[index]['reaction']['count'];

//                 String shareUrl = posts[index]['post_url'];

//                 islikeboollist.add(liked);
//                 issavepostboollist.add(savepost);

//                 var commentdata = posts[index];

//                 var multi_image = posts[index]['multi_image'];
//                 List? multiphoto = posts[index]['photo_multi'];

//                 String _post = posts[index]['postFile'];
//                 String post = BaseConstant.BASE_URL_DEMO + _post;
//                 // print('post--------$post');
//                 String? videothumb = posts[index]['postFileThumb'];
//                 String _videothumb = BaseConstant.BASE_URL_DEMO + videothumb!;

//                 pinpoststatus = posts[index]['is_post_pinned'];
//                 ispinpostList.add(pinpoststatus);

//                 return Container(
//                   color: kWhite,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       index == 0
//                           ? const Divider(color: kWhite)
//                           : const Divider(thickness: 5.0),
//                       Row(
//                         children: [
//                           Container(
//                             height: 50,
//                             width: 50,
//                             margin: const EdgeInsets.only(left: 15, top: 15),
//                             decoration: Palette.RoundGradient,
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: CircleAvatar(
//                                 backgroundImage:
//                                     CachedNetworkImageProvider(profileimage),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   '$fname $lname',
//                                   style: Palette.blacktext16,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Flexible(
//                                       child: Text(
//                                         '$username',
//                                         style: Palette.greytext14,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     const Icon(
//                                       Icons.access_time,
//                                       size: 13,
//                                       color: kGreyone,
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     Text(
//                                       '$posttime',
//                                       style: Palette.greytext14,
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           profileid == posteduserid
//                               ? _popupmenuforour(
//                                   postid,
//                                   iscommentstatus,
//                                   pinpoststatus,
//                                   index,
//                                   title,
//                                   postText,
//                                   group_id)
//                               : _popupmenuForOther(postid, index)
//                         ],
//                       ),
//                       Container(
//                           margin: const EdgeInsets.only(left: 20, top: 10),
//                           child: Text(
//                             title,
//                             style: Palette.blacktext14B,
//                           )),
//                       Container(
//                           margin: const EdgeInsets.only(left: 20, top: 10),
//                           child: Html(data: "$postText")),
//                       post.contains(".jpeg") ||
//                               post.contains(".jpg") ||
//                               post.contains(".png")
//                           ? Container(
//                               width: MediaQuery.of(context).size.width,
//                               height: MediaQuery.of(context).size.height / 2,
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       fit: BoxFit.contain,
//                                       image: CachedNetworkImageProvider(post))),
//                             )
//                           : _post.contains('.mp4')
//                               ? Container(
//                                   height: 200,
//                                   width: MediaQuery.of(context).size.width,
//                                   // decoration: BoxDecoration(
//                                   //     image: DecorationImage(
//                                   //         image: videothumb != '' ?
//                                   //         CachedNetworkImageProvider(_videothumb)
//                                   //             : AssetImage('assets/images/black_background.jpg')
//                                   //     )),
//                                   child: Stack(
//                                     alignment: Alignment.center,
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       VideoPlayScreen(
//                                                         video: post,
//                                                       )));
//                                         },
//                                         child: Container(
//                                           height: 50,
//                                           width: 50,
//                                           decoration: BoxDecoration(
//                                             color: kGreyone,
//                                             borderRadius:
//                                                 BorderRadius.circular(60),
//                                           ),
//                                           child: const Icon(
//                                               Icons.play_arrow_sharp),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               : multi_image == '1' && _post != " "
//                                   ? Container(
//                                       height: 350,

//                                       // width: MediaQuery.of(context).size.width,
//                                       //
//                                       // child: StaggeredGridView.countBuilder(
//                                       //   crossAxisCount: 2,
//                                       //   crossAxisSpacing: 10,
//                                       //   mainAxisSpacing: 5,
//                                       //   primary: false,
//                                       //   shrinkWrap: true,
//                                       //
//                                       //   staggeredTileBuilder: (index) => StaggeredTile.fit(1),
//                                       //   itemCount: multiphoto.length != null ? multiphoto.length :0,
//                                       //   itemBuilder: (context,i){
//                                       //    String  mulimage = multiphoto[index]['image'];
//                                       //    print(':::::::::::::::::::$mulimage');
//                                       //     return Container(
//                                       //       margin: EdgeInsets.fromLTRB(5, 5,5,5),
//                                       //       height: 200,
//                                       //       width: MediaQuery.of(context).size.width,
//                                       //       decoration: BoxDecoration(
//                                       //          // color: kGreyone,
//                                       //           image: DecorationImage(
//                                       //               fit: BoxFit.contain,
//                                       //               image: CachedNetworkImageProvider(mulimage))),F
//                                       //
//                                       //     );
//                                       //   },
//                                       //
//                                       // ),
//                                       child: StaggeredGridView.countBuilder(
//                                         // padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                                         crossAxisCount: 4,
//                                         itemCount: multiphoto!.length,
//                                         primary: true,
//                                         //shrinkWrap: false,
//                                         physics:
//                                             const NeverScrollableScrollPhysics(),
//                                         itemBuilder:
//                                             (BuildContext context, int index) {
//                                           String mulimage =
//                                               multiphoto[index]['image'];
//                                           return Container(
//                                             decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                     fit: BoxFit.contain,
//                                                     image:
//                                                         CachedNetworkImageProvider(
//                                                             mulimage))),
//                                           );
//                                           //   AnimationConfiguration.staggeredGrid(
//                                           //   columnCount: 3,
//                                           //   position: index,
//                                           //   duration: const Duration(milliseconds: 500),
//                                           //   child:Card(
//                                           //     shape: Palette.cardShape,
//                                           //     color: _balanceBgClr[index],
//                                           //     child: Container(
//                                           //       padding: EdgeInsets.all(15.0),
//                                           //       child: Column(
//                                           //         crossAxisAlignment: CrossAxisAlignment.start,
//                                           //         children: [
//                                           //           Visibility(
//                                           //             visible: index.isOdd ? false : true,
//                                           //             child: _balanceIcon[index],
//                                           //           ),
//                                           //           Visibility(
//                                           //             visible: index.isOdd ? false : true,
//                                           //             child: SizedBox(height: 20.0),
//                                           //           ),
//                                           //           Text(' ${_balanceName[index]} ',
//                                           //               style: Palette.whiteTitle),
//                                           //           SizedBox(height: 2.0),
//                                           //           _balanceName[index] == "Staking"
//                                           //               ? Text(
//                                           //             ' ${_balanceAmt[index]} ',
//                                           //             style: Palette.whiteTitle,
//                                           //           )
//                                           //               : Text(
//                                           //             ' ${_balanceAmt[index]} $kCurrency',
//                                           //             style: Palette.whiteTitle,
//                                           //           ),
//                                           //         ],
//                                           //       ),
//                                           //     ),
//                                           //   ),
//                                           // );
//                                         },
//                                         mainAxisSpacing: 5.0,
//                                         crossAxisSpacing: 5.0,
//                                         staggeredTileBuilder: (int index) {
//                                           return StaggeredTile.count(
//                                               2, index.isEven ? 2 : 1.5);
//                                         },
//                                       ),
//                                     )
//                                   : Container(),
//                       const SizedBox(height: 10),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, right: 15),
//                         child: Row(
//                           children: [
//                             Column(
//                               children: [
//                                 CircleAvatar(
//                                     radius: 20,
//                                     backgroundColor:
//                                         kThemeColorLightGrey.withOpacity(0.4),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           islikeboollist[index] =
//                                               !islikeboollist[index];
//                                           if (islikeboollist[index] == true) {
//                                             setState(() {
//                                               posts[index]['reaction']
//                                                   ['count']++;
//                                             });
//                                           } else {
//                                             setState(() {
//                                               posts[index]['reaction']
//                                                   ['count']--;
//                                             });
//                                           }
//                                           LikedBloc(
//                                               postid, _keyLoaderlike, context);
//                                         });
//                                       },
//                                       child: islikeboollist[index]
//                                           ? const Icon(
//                                               Icons.favorite,
//                                               color: kred,
//                                             )
//                                           : Icon(
//                                               Icons.favorite_outline_sharp,
//                                               color: Colors.black87
//                                                   .withOpacity(0.6),
//                                             ),
//                                     )),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   '${posts[index]['reaction']['count']}',
//                                   style: Palette.greytext12,
//                                 )
//                               ],
//                             ),
//                             Visibility(
//                               visible: iscommentstatus,
//                               child: Row(
//                                 children: [
//                                   const SizedBox(
//                                     width: 15,
//                                   ),
//                                   Column(
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           CommentScreen(
//                                                             commentdata:
//                                                                 commentdata,
//                                                           )))
//                                               .then((value) => setState(() {
//                                                     // pageno = '1';
//                                                     // _userTimeLineBloc = UserTimeLineBloc(
//                                                     //     pageno,widget.userid, _keyLoader, context);
//                                                     //_allpostBloc = AllpostBloc(pageno, _keyLoader, context);
//                                                   }));
//                                         },
//                                         child: CircleAvatar(
//                                           radius: 20,
//                                           backgroundColor: kThemeColorLightGrey
//                                               .withOpacity(0.4),
//                                           child: Container(
//                                             height: 20,
//                                             width: 20,
//                                             decoration: const BoxDecoration(
//                                                 image: DecorationImage(
//                                                     image: AssetImage(
//                                                         'assets/images/comment.png'))),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         '$comment',
//                                         style: Palette.greytext12,
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 15,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Share.share(
//                                         'check out this post on Better Solver ${posts[index]['post_url']}',
//                                         subject: '${posts[index]['title']}');
//                                     // sharePostDialogue(shareUrl);
//                                   },
//                                   child: CircleAvatar(
//                                     radius: 20,
//                                     backgroundColor:
//                                         kThemeColorLightGrey.withOpacity(0.4),
//                                     child: Container(
//                                       height: 20,
//                                       width: 20,
//                                       decoration: const BoxDecoration(
//                                           image: DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/postshareicon.png'))),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   '',
//                                   style: Palette.greytext12,
//                                 )
//                               ],
//                             ),
//                             const Spacer(),
//                             pinpoststatus == true
//                                 ? Column(
//                                     children: [
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       const Icon(
//                                         Icons.push_pin,
//                                         color: Colors.cyanAccent,
//                                         size: 28,
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                         '',
//                                         style: Palette.greytext12,
//                                       )
//                                     ],
//                                   )
//                                 : const SizedBox(),
//                             Column(
//                               children: [
//                                 GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         issavepostboollist[index] =
//                                             !issavepostboollist[index];
//                                         SavepostBloc(postid, _keyLoadersavepost,
//                                             context);
//                                       });
//                                     },
//                                     child: issavepostboollist[index]
//                                         ? const Icon(
//                                             Icons.bookmark,
//                                             color: Colors.blueAccent,
//                                             size: 28,
//                                           )
//                                         : const Icon(
//                                             Icons.bookmark_outline_sharp,
//                                             color: kGreyone,
//                                             size: 28,
//                                           )),
//                                 // Container(
//                                 //   height: 20,
//                                 //   width: 20,
//                                 //   decoration: BoxDecoration(
//                                 //       image: DecorationImage(
//                                 //           image: AssetImage(
//                                 //               'assets/images/saveposticon.png'))),
//                                 // ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   '',
//                                   style: Palette.greytext12,
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               });
//         });
//   }

//   fetchCatList() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     user_id = pref.getString('userid');
//     s = pref.getString('s');

//     String _url = BaseConstant.BASE_URL +
//         'demo2/app_api.php?application=phone&type=get_group';

//     try {
//       var response = await http.post(
//         Uri.parse(_url),
//         body: {
//           'user_id': user_id,
//           's': s,
//         },
//       );

//       var decode = json.decode(response.body);
//       print(decode);

//       if (response.statusCode == 200) {
//         if (decode['api_status'] == '200') {
//           setState(() {
//             categoryList = decode['group'];
//           });
//         } else {
//           setState(() {
//             categoryList = [];
//           });
//         }
//       } else {
//         setState(() {});
//       }
//     } catch (e) {
//       setState(() {});
//     }
//   }

//   void _showMoreBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       elevation: 10,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(40.0),
//           topLeft: Radius.circular(40.0),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Wrap(
//           children: [
//             Center(
//               child: Container(
//                 margin: const EdgeInsets.only(top: 8),
//                 width: 60,
//                 height: 5,
//                 decoration: Palette.buttonGradient,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     height: 50,
//                     margin: const EdgeInsets.only(left: 20, right: 20),
//                     decoration: Palette.cardShapGradient,
//                     child: Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             Navigator.pop(context);
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => CreatePostScreen()));
//                           });
//                         },
//                         child: Container(
//                             decoration: const BoxDecoration(
//                                 color: kWhite,
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(30),
//                                     bottomLeft: Radius.circular(30),
//                                     bottomRight: Radius.circular(25))),
//                             child: Container(
//                                 margin: const EdgeInsets.only(left: 15),
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   'CREATE POST',
//                                   style: Palette.greytext12,
//                                 ))),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     // width: MediaQuery.of(context).size.width / 1.4,
//                     height: 50,
//                     margin: const EdgeInsets.only(left: 20, right: 20),
//                     decoration: Palette.cardShapGradient,
//                     child: Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             Navigator.pop(context);
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         CreatePollPostScreen()));
//                           });
//                         },
//                         child: Container(
//                             decoration: const BoxDecoration(
//                                 color: kWhite,
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(30),
//                                     bottomLeft: Radius.circular(30),
//                                     bottomRight: Radius.circular(25))),
//                             child: Container(
//                                 margin: const EdgeInsets.only(left: 15),
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   'CREATE POLL',
//                                   style: Palette.greytext12,
//                                 ))),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   )
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildProgressIndicator() {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Opacity(
//         opacity: isLoading ? 1.0 : 00,
//         child: const CircularProgressIndicator(),
//       ),
//     );
//   }

//   Widget _popupmenuforour(String postid, bool type, bool pintype, int index,
//       String postTitle, String postText, String groupid) {
//     String typevalue = '0';
//     if (type == true) {
//       typevalue = '0';
//     } else {
//       typevalue = '1';
//     }
//     //print('/*-++-*//*-+');
//     return PopupMenuButton(
//         shape: Palette.cardShape,
//         offset: const Offset(100, 0),
//         elevation: 8.0,
//         //  enabled: true,
//         child: Container(
//           margin: const EdgeInsets.only(right: 10, top: 10),
//           child: const Icon(Icons.more_horiz),
//         ),
//         itemBuilder: (BuildContext context) => [
//               PopupMenuItem(
//                 value: 'Value1',
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                     edit_post_dialogue(postid, postTitle, postText, groupid);
//                   },
//                   child: Row(
//                     children: const <Widget>[
//                       Icon(Icons.edit, color: Colors.yellow),
//                       SizedBox(width: 10),
//                       Text('Edit Post'),
//                     ],
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'Value2',
//                 child: InkWell(
//                   child: Row(
//                     children: const <Widget>[
//                       Icon(Icons.delete, color: Colors.red),
//                       SizedBox(width: 10),
//                       Text('Delete Post'),
//                     ],
//                   ),
//                   onTap: () {
//                     setState(() {
//                       Navigator.pop(context);
//                       showAlertDialogDeletePost(context, postid, index);
//                     });
//                   },
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'Value3',
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       // print('typle $typevalue');
//                       //print('postid $postid');
//                       Navigator.pop(context);

//                       EnableDisableCommentBloc(
//                           postid, typevalue, _keyLoadercomment, context);

//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => HomeScreen()));
//                       // _allpostBloc!.allpostblocDataSink;

//                       setState(() {
//                         posts[index]['comments_status'] == "1"
//                             ? posts[index]['comments_status'] = "0"
//                             : posts[index]['comments_status'] = "1";
//                         _allpostBloc =
//                             AllpostBloc(_pageno.toString(), firstLoad);
//                       });

//                       // _userTimeLineBloc = UserTimeLineBloc(pageno, _keyLoader, context);
//                       // ispage = false;
//                     });
//                   },
//                   child: Row(
//                     children: <Widget>[
//                       typevalue == '0'
//                           ? const Icon(Icons.speaker_notes_off_outlined,
//                               color: Colors.blue)
//                           : const Icon(Icons.comment_outlined,
//                               color: Colors.blue),
//                       const SizedBox(width: 10),
//                       typevalue == '0'
//                           ? Text('Disable Comment')
//                           : Text('Enable Comment')
//                     ],
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'Value4',
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       Navigator.pop(context);
//                       PinPostBloc(postid, _keyLoaderpin, context);

//                       // _allpostBloc = AllpostBloc(pageno, _keyLoader, context);
//                     });
//                   },
//                   child: Row(
//                     children: <Widget>[
//                       const Icon(Icons.push_pin, color: Colors.cyanAccent),
//                       const SizedBox(width: 10),
//                       pintype == true ? Text('Unpin post') : Text('Pin Post'),
//                     ],
//                   ),
//                 ),
//               ),
//             ]);
//   }

//   Widget _popupmenuForOther(String postid, int index) {
//     return PopupMenuButton(
//         shape: Palette.cardShape,
//         offset: const Offset(100, 0),
//         elevation: 8.0,
//         child: Container(
//           margin: const EdgeInsets.only(right: 10, top: 10),
//           child: const Icon(Icons.more_horiz),
//         ),
//         itemBuilder: (BuildContext context) => [
//               PopupMenuItem(
//                 value: 'Value1',
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                     showAlertDialogForReport(context: context, postid: postid);
//                   },
//                   child: Row(
//                     children: <Widget>[
//                       const Icon(Icons.flag_outlined, color: Colors.yellow),
//                       const SizedBox(width: 10),
//                       Text('Report Post'),
//                     ],
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'Value2',
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                     showAlertDialogForHide(
//                         context: context, postid: postid, index: index);
//                   },
//                   child: Row(
//                     children: <Widget>[
//                       const Icon(Icons.remove_red_eye, color: Colors.red),
//                       const SizedBox(width: 10),
//                       Text('Hide Post'),
//                     ],
//                   ),
//                 ),
//               ),
//             ]);
//   }

//   showAlertDialogForReport(
//       {required BuildContext context, required String postid}) {
//     // set up the buttons
//     Widget cancelButton = MaterialButton(
//       child: Text(
//         "Cancel",
//         style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
//       ),
//       onPressed: () {
//         Navigator.pop(context, false);
//       },
//     );
//     Widget continueButton = MaterialButton(
//       child: Text(
//         "Yes",
//         style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
//       ),
//       onPressed: () {
//         Navigator.pop(context);
//         // Navigator.pop(context);
//         reportpostDialogue(context, postid);
//       },
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       // title:Text("Logout"),
//       content: Text("Are you sure to report this post?"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   showAlertDialogDeletePost(BuildContext context, String postid, int index) {
//     // set up the buttons
//     Widget cancelButton = MaterialButton(
//       child: Text(
//         "Cancel",
//         style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
//       ),
//       onPressed: () {
//         Navigator.pop(context, false);
//       },
//     );
//     Widget continueButton = MaterialButton(
//       child: Text(
//         "Yes",
//         style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
//       ),
//       onPressed: () {
//         Navigator.pop(context);
//         LoadingDialog.showLoadingDialog(context, _keyLoader);
//         DeletePostBloc(postid, _keyLoader, context, onSuccess: () {
//           setState(() {
//             posts.remove(index);
//           });
//         });
//         setState(() {
//           posts.remove(index);
//         });
//       },
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       // title:Text("Logout"),
//       content: Text("Are you sure to delete this post?"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   Future<void> reportpostDialogue(BuildContext context, String postid) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () async => false,
//           child: SimpleDialog(
//             backgroundColor: kWhite,
//             children: <Widget>[
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 30,
//                     decoration: Palette.loginGradient,
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 10),
//                       decoration: const BoxDecoration(
//                           color: kWhite,
//                           borderRadius: BorderRadius.only(
//                               bottomRight: Radius.circular(25),
//                               bottomLeft: Radius.circular(25))),
//                     ),
//                   ),
//                   const SizedBox(height: 10.0),
//                   Center(
//                     child: Text(
//                       'Report Post',
//                       style: Palette.appbarTitle,
//                     ),
//                   ),
//                   Container(
//                     height: 40,
//                     margin: const EdgeInsets.fromLTRB(35, 15, 35, 10),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: const LinearGradient(
//                             colors: [kThemeColorBlue, kThemeColorGreen])),
//                     child: Padding(
//                       padding: const EdgeInsets.all(0.8),
//                       child: TextField(
//                         controller: reportTextController,
//                         keyboardType: TextInputType.emailAddress,
//                         style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w400, fontSize: 12),
//                         decoration: InputDecoration(
//                           fillColor: kWhite,
//                           filled: true,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           disabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           contentPadding: const EdgeInsets.all(8.0),
//                           hintText: 'type somthing....',
//                           labelStyle: GoogleFonts.roboto(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 40,
//                         width: 80,
//                         decoration: BoxDecoration(
//                             color: kThemeColorBlue,
//                             borderRadius: BorderRadius.circular(10)),
//                         child: InkWell(
//                           onTap: () {
//                             reportTextController.clear();
//                             Navigator.pop(context);
//                           },
//                           child: const Center(
//                             child: Text('Cancel'),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 30,
//                       ),
//                       Container(
//                         height: 40,
//                         width: 80,
//                         decoration: BoxDecoration(
//                             color: kThemeColorLightBlue,
//                             borderRadius: BorderRadius.circular(10)),
//                         child: InkWell(
//                           onTap: () {
//                             //print('Post id ----$postid');
//                             //print('Post id ----${reportTextController.text}');
//                             if (reportTextController.text.isEmpty) {
//                               ErrorDialouge.showErrorDialogue(
//                                   context, _keyError, "Please write something");
//                             } else {
//                               ReportPostBloc(postid, reportTextController.text,
//                                   _keyLoaderreport, context);
//                               reportTextController.clear();
//                               Navigator.pop(context);
//                             }
//                           },
//                           child: const Center(
//                             child: Text('Report'),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> sharePostDialogue(String post_url) async {
//     return showDialog<void>(
//       context: context,
//       // barrierDismissible: false,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           children: <Widget>[
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.only(right: 10),
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: Icon(Icons.highlight_remove_outlined),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: Text(
//                     'Share Post',
//                     style: Palette.appbarTitle,
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         //shareWhatsapp(post_url);
//                       },
//                       child: Card(
//                         elevation: 10,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Container(
//                           padding: const EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: kThemeColorBlue)),
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: const BoxDecoration(
//                                 color: kWhite,
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/twitter_logo.png'))),
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: Card(
//                         elevation: 10,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Container(
//                           padding: const EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: kThemeColorBlue)),
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: const BoxDecoration(
//                                 color: kWhite,
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/facebook_logo.png'))),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: Card(
//                         elevation: 10,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Container(
//                           padding: const EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: kThemeColorBlue)),
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: const BoxDecoration(
//                                 color: kWhite,
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/whatsapp_logo.png'))),
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: Card(
//                         elevation: 10,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Container(
//                           padding: const EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: kThemeColorBlue)),
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: const BoxDecoration(
//                                 color: kWhite,
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/pinterest_logo.png'))),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: Card(
//                         elevation: 10,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Container(
//                           padding: const EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: kThemeColorBlue)),
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: const BoxDecoration(
//                                 color: kWhite,
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/linkedin_logo.png'))),
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: Card(
//                         elevation: 10,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Container(
//                           padding: const EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: kThemeColorBlue)),
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: const BoxDecoration(
//                                 color: kWhite,
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/telegram_logo.png'))),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Card(
//                   elevation: 10,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   margin: const EdgeInsets.only(right: 15, left: 15),
//                   child: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: const LinearGradient(
//                             colors: [kThemeColorBlue, kThemeColorGreen])),
//                     child: Padding(
//                       padding: const EdgeInsets.all(0.8),
//                       child: TextField(
//                         controller: reportTextController,
//                         keyboardType: TextInputType.emailAddress,
//                         style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w400, fontSize: 12),
//                         decoration: InputDecoration(
//                           fillColor: kWhite,
//                           filled: true,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           disabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           contentPadding: const EdgeInsets.all(8.0),
//                           hintText: 'type somthing....',
//                           labelStyle: GoogleFonts.roboto(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text('share the post on'),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Card(
//                   margin: const EdgeInsets.only(right: 15, left: 15),
//                   elevation: 10,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Container(
//                       padding: const EdgeInsets.all(10.0),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: kThemeColorBlue)),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 35,
//                             width: 35,
//                             decoration: const BoxDecoration(
//                                 color: kWhite,
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/mytimelineicon.png'))),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           const Expanded(child: Text('My Timeline'))
//                         ],
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Center(
//                   child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text(
//                         'Share',
//                         style: Palette.whiteText15,
//                       )),
//                 )
//               ],
//             )
//           ],
//         );
//       },
//     );
//   }

//   // shareWhatsapp(String postId) async {
//   //   String msg =  postId;
//   //   //String url = 'https://bettersolver.com/demo2/post' + postId;
//   //   String response;
//   //   final FlutterShareMe flutterShareMe = FlutterShareMe();
//   //   response = await flutterShareMe.shareToWhatsApp(msg: msg);
//   // }

//   Future<void> edit_post_dialogue(
//       String post_id, String title1, String title2, String cat_id) async {
//     titleController.text = title1;
//     postTextController.text = title2;
//     categoryType = cat_id;

//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () async => false,
//           child: SimpleDialog(
//             backgroundColor: kWhite,
//             children: <Widget>[
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 30,
//                     decoration: Palette.loginGradient,
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 10),
//                       decoration: const BoxDecoration(
//                           color: kWhite,
//                           borderRadius: BorderRadius.only(
//                               bottomRight: Radius.circular(25),
//                               bottomLeft: Radius.circular(25))),
//                     ),
//                   ),
//                   const SizedBox(height: 10.0),
//                   Text(
//                     'Edit Post',
//                     style: Palette.appbarTitle,
//                   ),
//                   const SizedBox(height: 10.0),
//                   Container(
//                     height: 40,
//                     margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: const LinearGradient(
//                             colors: [kThemeColorBlue, kThemeColorGreen])),
//                     child: Padding(
//                       padding: const EdgeInsets.all(0.8),
//                       child: TextField(
//                         controller: titleController,
//                         keyboardType: TextInputType.emailAddress,
//                         style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w400, fontSize: 12),
//                         decoration: InputDecoration(
//                           fillColor: kWhite,
//                           filled: true,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           disabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           contentPadding: const EdgeInsets.all(8.0),
//                           hintText: 'Title',
//                           labelStyle: GoogleFonts.roboto(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 5.0),
//                   Container(
//                     height: 40,
//                     margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
//                     padding: const EdgeInsets.all(1),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: const LinearGradient(
//                             colors: [kThemeColorBlue, kThemeColorGreen])),
//                     child: DropdownButtonFormField(
//                       isExpanded: true,
//                       // icon: Icon(Icons.add_location),
//                       style: GoogleFonts.roboto(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12.0,
//                       ),
//                       value: categoryType,
//                       hint: Text(
//                         'Select Category',
//                         style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 12,
//                             color: kBlack),
//                       ),
//                       items: categoryList.map((item) {
//                         return DropdownMenuItem(
//                           child: Text(
//                             item['category'],
//                             style: Palette.black_title,
//                           ),
//                           value: item['id'],
//                         );
//                       }).toList(),
//                       decoration: InputDecoration(
//                         fillColor: kWhite,
//                         filled: true,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Colors.transparent, width: 1.0),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Colors.transparent, width: 1.0),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Colors.transparent, width: 1.0),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         disabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Colors.transparent, width: 1.0),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         contentPadding: const EdgeInsets.all(8.0),
//                         hintText: 'type somthing....',
//                         labelStyle: GoogleFonts.roboto(color: Colors.grey),
//                       ),
//                       onChanged: (newValue) {
//                         setState(() {
//                           categoryType = newValue;
//                         });
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 5.0),
//                   Container(
//                     height: 40,
//                     margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: const LinearGradient(
//                             colors: [kThemeColorBlue, kThemeColorGreen])),
//                     child: Padding(
//                       padding: const EdgeInsets.all(0.8),
//                       child: TextField(
//                         controller: postTextController,
//                         keyboardType: TextInputType.emailAddress,
//                         style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.w400, fontSize: 12),
//                         decoration: InputDecoration(
//                           fillColor: kWhite,
//                           filled: true,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           disabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           contentPadding: const EdgeInsets.all(8.0),
//                           hintText: 'type somthing....',
//                           labelStyle: GoogleFonts.roboto(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15.0),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 20, left: 20),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             height: 40,
//                             decoration: BoxDecoration(
//                                 color: kThemeColorBlue,
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: InkWell(
//                               onTap: () {
//                                 reportTextController.clear();
//                                 Navigator.pop(context);
//                               },
//                               child: Center(
//                                 child: Text(
//                                   'Cancel',
//                                   style: Palette.splashscreenskip,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 30,
//                         ),
//                         Expanded(
//                             child: Container(
//                           height: 40,
//                           decoration: BoxDecoration(
//                               color: kThemeColorLightBlue,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                               //LoadingDialog.showLoadingDialog(context, _keyLoader);
//                               EditPostBloc(
//                                   post_id,
//                                   postTextController.text,
//                                   categoryType,
//                                   titleController.text,
//                                   _keyLoader,
//                                   context);
//                             },
//                             child: Center(
//                               child: Text(
//                                 'Update',
//                                 style: Palette.splashscreenskip,
//                               ),
//                             ),
//                           ),
//                         ))
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   showAlertDialogForHide(
//       {required BuildContext context,
//       required String postid,
//       required int index}) {
//     // set up the buttons
//     Widget cancelButton = MaterialButton(
//       child: Text(
//         "Cancel",
//         style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
//       ),
//       onPressed: () {
//         Navigator.pop(context, false);
//       },
//     );
//     Widget continueButton = MaterialButton(
//       child: Text(
//         "Yes",
//         style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
//       ),
//       onPressed: () {
//         setState(() {
//           Navigator.pop(context);
//           LoadingDialog.showLoadingDialog(context, _keyLoader);
//           HidePostBloc(postid, _keyLoader, context);
//           // _allpostBloc = AllpostBloc(_pageno.toString(), firstLoad);
//         });
//         setState(() {
//           posts.remove(index);
//         });
//       },
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       // title:Text("Logout"),
//       content: Text("Are you sure to Hide this post?"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
