// import 'package:bettersolver/bloc/category_details_bloc.dart';
// import 'package:bettersolver/bloc/enable_disable_comment_bloc.dart';
// import 'package:bettersolver/bloc/liked_bloc.dart';
// import 'package:bettersolver/bloc/pinpost_bloc.dart';
// import 'package:bettersolver/bloc/report_post_bloc.dart';
// import 'package:bettersolver/bloc/saved_post_bloc.dart';
// import 'package:bettersolver/models/category_details_model.dart';
// import 'package:bettersolver/screen/create_post/get_post_comment_screen.dart';
// import 'package:bettersolver/screen/create_post/post_comment_screen.dart';
// import 'package:bettersolver/style/constants.dart';
// import 'package:bettersolver/style/palette.dart';
// import 'package:bettersolver/utils/base_constant.dart';
// import 'package:bettersolver/utils/loading.dart';
// import 'package:bettersolver/utils/response.dart';
// import 'package:bettersolver/widgets/error_dialouge.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

// class TextPost extends StatefulWidget {
//   String? groupid;

//   TextPost({super.key, this.groupid});

//   @override
//   State<TextPost> createState() => _TextPostState();
// }

// class _TextPostState extends State<TextPost> {
//   CategoryDetailsBloc? _categoryDetailsBloc;

//   final GlobalKey<State> _keyLoader = GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderlike = GlobalKey<State>();
//   final GlobalKey<State> _keyLoadersavepost = GlobalKey<State>();
//   final GlobalKey<State> _keyLoadercomment = GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderreport = GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderhide = GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderpin = GlobalKey<State>();
//   final GlobalKey<State> _keyError = GlobalKey<State>();

//   TextEditingController reportTextController = TextEditingController();

//   var alldata;

//   List alltextList = [];

//   bool liked = false;
//   List islikeboollist = [];

//   bool savepost = false;
//   List issavepostboollist = [];

//   String? profileid;

//   bool pinpoststatus = false;
//   List ispinpostList = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _categoryDetailsBloc =
//         CategoryDetailsBloc(widget.groupid!, _keyLoader, context);
//     shared();
//   }

//   shared() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     profileid = pref.getString('userid');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: kWhite,
//         appBar: AppBar(
//           title: const Text('Photos'),
//           centerTitle: true,
//           backgroundColor: kWhite,
//           elevation: 0,
//         ),
//         body: StreamBuilder(
//             stream: _categoryDetailsBloc!.categorydetailsblocDataStream,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 switch (snapshot.data.status) {
//                   case Status.LOADING:
//                     return Loading(loadingMessage: snapshot.data.message);

//                   case Status.COMPLETED:
//                     return _listpost(snapshot.data.data);

//                   case Status.ERROR:
//                     return const Text(
//                       'Errror msg',
//                     );
//                 }
//               }
//               return Container();
//             }));
//   }

//   Widget _listpost(CategoryDetailsModel categoryDetailsModel) {
//     alldata = categoryDetailsModel.categoryDetailData;
//     alltextList = alldata['text_post'];

//     return ListView.builder(
//         itemCount: alltextList != null ? alltextList.length : 0,
//         shrinkWrap: true,
//         primary: false,
//         itemBuilder: (Context, index) {
//           String postid = alltextList[index]['post_id'];
//           String posteduserid = alltextList[index]['publisher']['user_id'];

//           String username = alltextList[index]['publisher']['username'];
//           String profileimage = alltextList[index]['publisher']['avatar'];
//           String fname = alltextList[index]['publisher']['first_name'] ?? '-';
//           String lname = alltextList[index]['publisher']['last_name'] ?? '-';
//           String posttime = alltextList[index]['post_time'];
//           String comment = alltextList[index]['post_comments'];
//           String title = alltextList[index]['title'];
//           String postText = alltextList[index]['postText'];
//           savepost = alltextList[index]['is_post_saved'];
//           liked = alltextList[index]['reaction']['is_reacted'];
//           int likecount = alltextList[index]['reaction']['count'];

//           String commentstatus = alltextList[index]['comments_status'];
//           bool iscommentstatus = false;

//           if (commentstatus.contains("1")) {
//             iscommentstatus = true;
//           } else {
//             iscommentstatus = false;
//           }

//           var commentdata = alltextList[index];
//           print('commentdata-----$commentdata');

//           islikeboollist.add(liked);
//           issavepostboollist.add(savepost);

//           print('islikeboollist -/////////////////--$islikeboollist');
//           print(
//               'issavepostboollist ==========================$issavepostboollist');

//           var multiImage = alltextList[index]['multi_image'];
//           List? multiphoto = alltextList[index]['photo_multi'];

//           print('multiphoto $multiphoto');

//           String post0 = alltextList[index]['postFile'];

//           String post = BaseConstant.BASE_URL_DEMO + post0;

//           pinpoststatus = alltextList[index]['is_post_pinned'];
//           ispinpostList.add(pinpoststatus);

//           return Container(
//             color: kWhite,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       height: 50,
//                       width: 50,
//                       margin: const EdgeInsets.only(left: 15, top: 15),
//                       decoration: Palette.RoundGradient,
//                       child: Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: CircleAvatar(
//                           backgroundImage:
//                               CachedNetworkImageProvider(profileimage),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 10),
//                           Text(
//                             '$fname $lname',
//                             style: Palette.blacktext16,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 username,
//                                 style: Palette.greytext14,
//                               ),
//                               const SizedBox(width: 5),
//                               const Icon(
//                                 Icons.access_time,
//                                 size: 13,
//                                 color: kGreyone,
//                               ),
//                               const SizedBox(width: 5),
//                               Text(
//                                 posttime,
//                                 style: Palette.greytext14,
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     profileid == posteduserid
//                         ? _popupmenuforour(
//                             postid, iscommentstatus, pinpoststatus)
//                         : _popupmenuforother(postid)
//                   ],
//                 ),
//                 Container(
//                     margin: const EdgeInsets.only(left: 20, top: 10),
//                     child: Text(
//                       title,
//                       style: Palette.blacktext14B,
//                     )),
//                 Container(
//                   margin: const EdgeInsets.only(left: 20, top: 10),
//                   child: Html(data: postText),
//                 ),

//                 multiImage == "0" && post0 == ""
//                     ? const SizedBox()
//                     : const Divider(thickness: 1.0),

//                 multiImage == "0" && post0 == ""
//                     ? const SizedBox()
//                     : multiImage != '1' && post0 != " "
//                         ? Container(
//                             // width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height / 3,
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     fit: BoxFit.contain,
//                                     image: CachedNetworkImageProvider(post))),
//                           )
//                         : SizedBox(
//                             // width: MediaQuery.of(context).size.width,
//                             height: 350,
//                             //
//                             // child: StaggeredGridView.countBuilder(
//                             //   crossAxisCount: 2,
//                             //   crossAxisSpacing: 10,
//                             //   mainAxisSpacing: 5,
//                             //   primary: false,
//                             //   shrinkWrap: true,
//                             //
//                             //   staggeredTileBuilder: (index) => StaggeredTile.fit(1),
//                             //   itemCount: multiphoto.length != null ? multiphoto.length :0,
//                             //   itemBuilder: (context,i){
//                             //    String  mulimage = multiphoto[index]['image'];
//                             //    print(':::::::::::::::::::$mulimage');
//                             //     return Container(
//                             //       margin: EdgeInsets.fromLTRB(5, 5,5,5),
//                             //       height: 200,
//                             //       width: MediaQuery.of(context).size.width,
//                             //       decoration: BoxDecoration(
//                             //          // color: kGreyone,
//                             //           image: DecorationImage(
//                             //               fit: BoxFit.contain,
//                             //               image: CachedNetworkImageProvider(mulimage))),
//                             //
//                             //     );
//                             //   },
//                             //
//                             // ),

//                             child: StaggeredGridView.countBuilder(
//                               // padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                               crossAxisCount: 4,
//                               itemCount: multiphoto!.length,
//                               primary: true,
//                               //shrinkWrap: false,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (BuildContext context, int index) {
//                                 String mulimage = multiphoto[index]['image'];
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           fit: BoxFit.contain,
//                                           image: CachedNetworkImageProvider(
//                                               mulimage))),
//                                 );
//                                 //   AnimationConfiguration.staggeredGrid(
//                                 //   columnCount: 3,
//                                 //   position: index,
//                                 //   duration: const Duration(milliseconds: 500),
//                                 //   child:Card(
//                                 //     shape: Palette.cardShape,
//                                 //     color: _balanceBgClr[index],
//                                 //     child: Container(
//                                 //       padding: EdgeInsets.all(15.0),
//                                 //       child: Column(
//                                 //         crossAxisAlignment: CrossAxisAlignment.start,
//                                 //         children: [
//                                 //           Visibility(
//                                 //             visible: index.isOdd ? false : true,
//                                 //             child: _balanceIcon[index],
//                                 //           ),
//                                 //           Visibility(
//                                 //             visible: index.isOdd ? false : true,
//                                 //             child: SizedBox(height: 20.0),
//                                 //           ),
//                                 //           Text(' ${_balanceName[index]} ',
//                                 //               style: Palette.whiteTitle),
//                                 //           SizedBox(height: 2.0),
//                                 //           _balanceName[index] == "Staking"
//                                 //               ? Text(
//                                 //             ' ${_balanceAmt[index]} ',
//                                 //             style: Palette.whiteTitle,
//                                 //           )
//                                 //               : Text(
//                                 //             ' ${_balanceAmt[index]} $kCurrency',
//                                 //             style: Palette.whiteTitle,
//                                 //           ),
//                                 //         ],
//                                 //       ),
//                                 //     ),
//                                 //   ),
//                                 // );
//                               },
//                               mainAxisSpacing: 5.0,
//                               crossAxisSpacing: 5.0,
//                               staggeredTileBuilder: (int index) {
//                                 return StaggeredTile.count(
//                                     2, index.isEven ? 2 : 1.5);
//                               },
//                             ),
//                           ),
//                 //     :Container(),
//                 // SizedBox(
//                 //   height: 8,
//                 // ),
//                 // Container(
//                 //     margin: EdgeInsets.only(left: 15),
//                 //     child: Text(
//                 //       '14 minutes ago',
//                 //       style: Palette.greytext12,
//                 //       textAlign: TextAlign.start,
//                 //     )),
//                 const Divider(thickness: 1.0),
//                 Container(
//                   margin: const EdgeInsets.only(left: 15, right: 15),
//                   child: Row(
//                     children: [
//                       Column(
//                         children: [
//                           CircleAvatar(
//                               radius: 20,
//                               backgroundColor:
//                                   kThemeColorLightGrey.withOpacity(0.4),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     islikeboollist[index] =
//                                         !islikeboollist[index];
//                                     print('like_ 1 counr+++ $likecount');

//                                     if (islikeboollist[index] == true) {
//                                       setState(() {
//                                         alltextList[index]['reaction']
//                                             ['count']++;
//                                         print(
//                                             'like_counr+++++++++++++++ $likecount');
//                                       });
//                                     } else {
//                                       setState(() {
//                                         alltextList[index]['reaction']
//                                             ['count']--;
//                                         print(
//                                             'like_counr---------------------$likecount');
//                                       });
//                                     }
//                                     LikedBloc(postid, _keyLoaderlike, context);
//                                   });
//                                 },
//                                 child: islikeboollist[index]
//                                     ? const Icon(
//                                         Icons.favorite,
//                                         color: kred,
//                                       )
//                                     : Icon(
//                                         Icons.favorite_outline_sharp,
//                                         color: Colors.black87.withOpacity(0.6),
//                                       ),
//                               )),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             '${alltextList[index]['reaction']['count']}',
//                             style: Palette.greytext12,
//                           )
//                         ],
//                       ),
//                       Visibility(
//                         visible: iscommentstatus,
//                         child: Row(
//                           children: [
//                             const SizedBox(
//                               width: 15,
//                             ),
//                             Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => CommentScreen(
//                                                   commentdata: commentdata,
//                                                 ))).then(
//                                         (value) => setState(() {
//                                               print(
//                                                   'api_called:::::::::::${widget.groupid}');
//                                               //  _listpost(categoryDetailsModel);
//                                               _categoryDetailsBloc =
//                                                   CategoryDetailsBloc(
//                                                       widget.groupid!,
//                                                       _keyLoader,
//                                                       context);
//                                             }));
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
//                                                   'assets/images/comment.png'))),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   comment,
//                                   style: Palette.greytext12,
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 15,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           CircleAvatar(
//                             radius: 20,
//                             backgroundColor:
//                                 kThemeColorLightGrey.withOpacity(0.4),
//                             child: Container(
//                               height: 20,
//                               width: 20,
//                               decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage(
//                                           'assets/images/postshareicon.png'))),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             '',
//                             style: Palette.greytext12,
//                           )
//                         ],
//                       ),
//                       const Spacer(),
//                       pinpoststatus == true
//                           ? Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 const Icon(
//                                   Icons.push_pin,
//                                   color: Colors.cyanAccent,
//                                   size: 28,
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   '',
//                                   style: Palette.greytext12,
//                                 )
//                               ],
//                             )
//                           : const SizedBox(),
//                       Column(
//                         children: [
//                           GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   issavepostboollist[index] =
//                                       !issavepostboollist[index];

//                                   SavepostBloc(
//                                       postid, _keyLoadersavepost, context);
//                                 });
//                               },
//                               child: issavepostboollist[index]
//                                   ? const Icon(
//                                       Icons.bookmark,
//                                       color: Colors.blueAccent,
//                                       size: 28,
//                                     )
//                                   : const Icon(
//                                       Icons.bookmark_outline_sharp,
//                                       color: kGreyone,
//                                       size: 28,
//                                     )),
//                           // Container(
//                           //   height: 20,
//                           //   width: 20,
//                           //   decoration: BoxDecoration(
//                           //       image: DecorationImage(
//                           //           image: AssetImage(
//                           //               'assets/images/saveposticon.png'))),
//                           // ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             '',
//                             style: Palette.greytext12,
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Divider()
//               ],
//             ),
//           );
//         });
//   }

//   Widget _popupmenuforour(String postid, bool typecomment, bool pintype) {
//     String typevaluecomment = '0';

//     if (typecomment == true) {
//       typevaluecomment = '0';
//     } else {
//       typevaluecomment = '1';
//     }
//     print('/*-++-*//*-+');
//     return PopupMenuButton(
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
//                   onTap: () {},
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
//                   onTap: () {},
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'Value3',
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       EnableDisableCommentBloc(
//                           postid, typevaluecomment, _keyLoadercomment, context);
//                       Navigator.pop(context);
//                       _categoryDetailsBloc = CategoryDetailsBloc(
//                           widget.groupid!, _keyLoader, context);
//                     });
//                   },
//                   child: Row(
//                     children: <Widget>[
//                       typevaluecomment == '0'
//                           ? const Icon(Icons.speaker_notes_off_outlined,
//                               color: Colors.blue)
//                           : const Icon(Icons.comment_outlined,
//                               color: Colors.blue),
//                       const SizedBox(width: 10),
//                       typevaluecomment == '0'
//                           ? const Text('Disable Comment')
//                           : const Text('Enable Comment')
//                     ],
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'Value4',
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       PinPostBloc(postid, _keyLoaderpin, context);
//                       Navigator.pop(context);

//                       _categoryDetailsBloc = CategoryDetailsBloc(
//                           widget.groupid!, _keyLoader, context);
//                     });
//                   },
//                   child: Row(
//                     children: <Widget>[
//                       const Icon(Icons.push_pin, color: Colors.cyanAccent),
//                       const SizedBox(width: 10),
//                       pintype == true
//                           ? const Text('Unpin post')
//                           : const Text('Pin Post'),
//                     ],
//                   ),
//                 ),
//               ),
//             ]);
//   }

//   Widget _popupmenuforother(String postid) {
//     print('/*-++-*//*-+');
//     return PopupMenuButton(
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

//                     showAlertDialog(context: context, postid: postid);
//                   },
//                   child: Row(
//                     children: const <Widget>[
//                       Icon(Icons.flag_outlined, color: Colors.yellow),
//                       SizedBox(width: 10),
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
//                     showAlertDialogForHide(context: context, postid: postid);
//                   },
//                   child: Row(
//                     children: const <Widget>[
//                       Icon(Icons.remove_red_eye, color: Colors.red),
//                       SizedBox(width: 10),
//                       Text('Hide Post'),
//                     ],
//                   ),
//                 ),
//               ),
//             ]);
//   }

//   showAlertDialog({required BuildContext context, required String postid}) {
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
//       content: const Text("Are you sure to report this post?"),
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
//                             print('Post id ----$postid');
//                             print('Post id ----${reportTextController.text}');
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

//   showAlertDialogForHide(
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
//         setState(() {
//           setState(() {
//             Navigator.pop(context);
//             print('--------postid ----------$postid');
//             // HidePostBloc(postid, _keyLoaderhide, context);
//             //_savePostListBloc = SavePostListBloc(_keyLoader, context);
//           });
//         });
//       },
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       // title:Text("Logout"),
//       content: const Text("Are you sure to Hide this post?"),
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
