// import 'package:bettersolver/bloc/category_details_bloc.dart';
// import 'package:bettersolver/bloc/enable_disable_comment_bloc.dart';
// import 'package:bettersolver/bloc/liked_bloc.dart';
// import 'package:bettersolver/bloc/pinpost_bloc.dart';
// import 'package:bettersolver/bloc/report_post_bloc.dart';
// import 'package:bettersolver/bloc/saved_post_bloc.dart';
// import 'package:bettersolver/models/category_details_model.dart';
// import 'package:bettersolver/screen/create_post/get_post_comment_screen.dart';
// import 'package:bettersolver/screen/create_post/post_comment_screen.dart';
// import 'package:bettersolver/screen/profile/video_play_screen.dart';
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

// class Video extends StatefulWidget {
//   String? groupid;

//   Video({this.groupid});

//   @override
//   State<Video> createState() => _VideoState();
// }

// class _VideoState extends State<Video> {
//   CategoryDetailsBloc? _categoryDetailsBloc;
//   final GlobalKey<State> _keyLoader = new GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderlike = new GlobalKey<State>();
//   final GlobalKey<State> _keyLoadersavepost = new GlobalKey<State>();
//   final GlobalKey<State> _keyLoadercomment = new GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderreport = new GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderpin = new GlobalKey<State>();
//   final GlobalKey<State> _keyLoaderhide = GlobalKey<State>();
//   final GlobalKey<State> _keyError = new GlobalKey<State>();

//   TextEditingController reportTextController = TextEditingController();

//   var alldata;

//   List allvideos = [];

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
//           title: Text('Videos'),
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
//                     break;
//                   case Status.COMPLETED:
//                     return _listpost(snapshot.data.data);
//                     break;
//                   case Status.ERROR:
//                     return Text(
//                       'Errror msg',
//                     );
//                     break;
//                 }
//               }
//               return Container();
//             }));
//   }

//   Widget _listpost(CategoryDetailsModel categoryDetailsModel) {
//     alldata = categoryDetailsModel.categoryDetailData;
//     allvideos = alldata['video_post'];

//     return ListView.builder(
//         itemCount: allvideos != null ? allvideos.length : 0,
//         shrinkWrap: true,
//         primary: false,
//         itemBuilder: (Context, index) {
//           String postid = allvideos[index]['post_id'];
//           String posteduserid = allvideos[index]['publisher']['user_id'];

//           String username = allvideos[index]['publisher']['username'];
//           String profileimage = allvideos[index]['publisher']['avatar'];
//           String fname = allvideos[index]['publisher']['first_name'] ?? '-';
//           String lname = allvideos[index]['publisher']['last_name'] ?? '-';
//           String posttime = allvideos[index]['post_time'];
//           String comment = allvideos[index]['post_comments'];
//           String title = allvideos[index]['title'];
//           String postText = allvideos[index]['postText'];
//           savepost = allvideos[index]['is_post_saved'];
//           liked = allvideos[index]['reaction']['is_reacted'];
//           int likecount = allvideos[index]['reaction']['count'];

//           String commentstatus = allvideos[index]['comments_status'];
//           bool iscommentstatus = false;

//           if (commentstatus.contains("1")) {
//             iscommentstatus = true;
//           } else {
//             iscommentstatus = false;
//           }

//           String _video =
//               BaseConstant.BASE_URL_DEMO + allvideos[index]['postFile_full'];

//           print('vieo - $_video');

//           String videothumb = allvideos[index]['postFileThumb'];
//           String _videothumb = BaseConstant.BASE_URL_DEMO + videothumb;

//           var commentdata = allvideos[index];
//           print('commentdata-----$commentdata');

//           islikeboollist.add(liked);
//           issavepostboollist.add(savepost);

//           print('islikeboollist -/////////////////--$islikeboollist');
//           print(
//               'issavepostboollist ==========================$issavepostboollist');

//           // var multi_image = allvideos[index]['multi_image'];
//           // List multiphoto = allvideos[index]['photo_multi'];

//           //  print('multiphoto $multiphoto');

//           // String _post = allvideos[index]['postFile'];
//           //
//           // String post = BaseConstant.BASE_URL_DEMO + _post;

//           pinpoststatus = allvideos[index]['is_post_pinned'];
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
//                       margin: EdgeInsets.only(left: 15, top: 15),
//                       decoration: Palette.RoundGradient,
//                       child: Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: CircleAvatar(
//                           backgroundImage:
//                               CachedNetworkImageProvider(profileimage),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             '$fname $lname',
//                             style: Palette.blacktext16,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 '$username',
//                                 style: Palette.greytext14,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(
//                                 Icons.access_time,
//                                 size: 13,
//                                 color: kGreyone,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text(
//                                 '$posttime',
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
//                     margin: EdgeInsets.only(left: 20, top: 10),
//                     child: Text(
//                       title,
//                       style: Palette.blacktext14B,
//                     )),
//                 Container(
//                     margin: EdgeInsets.only(left: 20, top: 10),
//                     child: Html(data: "$postText")),
//                 Divider(thickness: 1.0),
//                 videothumb != ''
//                     ? Container(
//                         height: 200,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image:
//                                     CachedNetworkImageProvider(_videothumb))),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => VideoPlayScreen(
//                                               video: allvideos[index]
//                                                   ['postFile_full'],
//                                             )));
//                               },
//                               child: Container(
//                                 height: 50,
//                                 width: 50,
//                                 decoration: BoxDecoration(
//                                   color: kGreyone,
//                                   borderRadius: BorderRadius.circular(60),
//                                 ),
//                                 child: Icon(Icons.play_arrow_sharp),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : Container(
//                         height: 200,
//                         width: MediaQuery.of(context).size.width,
//                         margin: EdgeInsets.only(left: 10, right: 10),
//                         color: kBlack,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => VideoPlayScreen(
//                                               video: allvideos[index]
//                                                   ['postFile_full'],
//                                             )));
//                               },
//                               child: Container(
//                                 height: 50,
//                                 width: 50,
//                                 decoration: BoxDecoration(
//                                   color: kWhite.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(60),
//                                 ),
//                                 child: Icon(Icons.play_arrow_sharp),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                 Divider(thickness: 1.0),
//                 Container(
//                   margin: EdgeInsets.only(left: 15, right: 15),
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
//                                         allvideos[index]['reaction']['count']++;
//                                         print(
//                                             'like_counr+++++++++++++++ $likecount');
//                                       });
//                                     } else {
//                                       setState(() {
//                                         allvideos[index]['reaction']['count']--;
//                                         print(
//                                             'like_counr---------------------$likecount');
//                                       });
//                                     }
//                                     LikedBloc(postid, );
//                                   });
//                                 },
//                                 child: islikeboollist[index]
//                                     ? Icon(
//                                         Icons.favorite,
//                                         color: kred,
//                                       )
//                                     : Icon(
//                                         Icons.favorite_outline_sharp,
//                                         color: Colors.black87.withOpacity(0.6),
//                                       ),
//                               )),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             '${allvideos[index]['reaction']['count']}',
//                             style: Palette.greytext12,
//                           )
//                         ],
//                       ),
//                       Visibility(
//                         visible: iscommentstatus,
//                         child: Row(
//                           children: [
//                             SizedBox(
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
//                                       decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/comment.png'))),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   '$comment',
//                                   style: Palette.greytext12,
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
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
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage(
//                                           'assets/images/postshareicon.png'))),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             '',
//                             style: Palette.greytext12,
//                           )
//                         ],
//                       ),
//                       Spacer(),
//                       pinpoststatus == true
//                           ? Column(
//                               children: [
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Icon(
//                                   Icons.push_pin,
//                                   color: Colors.cyanAccent,
//                                   size: 28,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   '',
//                                   style: Palette.greytext12,
//                                 )
//                               ],
//                             )
//                           : SizedBox(),
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
//                                   ? Icon(
//                                       Icons.bookmark,
//                                       color: Colors.blueAccent,
//                                       size: 28,
//                                     )
//                                   : Icon(
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
//                           SizedBox(
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
//                 SizedBox(height: 20),
//                 Divider()
//               ],
//             ),
//           );
//         });
//   }

//   Widget _popupmenuforour(String postid, bool type, bool pintype) {
//     String typevalue = '0';

//     if (type == true) {
//       typevalue = '0';
//     } else {
//       typevalue = '1';
//     }

//     print('/*-++-*//*-+');
//     return PopupMenuButton(
//         offset: const Offset(100, 0),
//         elevation: 8.0,
//         //  enabled: true,

//         child: Container(
//           margin: EdgeInsets.only(right: 10, top: 10),
//           child: Icon(Icons.more_horiz),
//         ),
//         itemBuilder: (BuildContext context) => [
//               PopupMenuItem(
//                 value: 'Value1',
//                 child: InkWell(
//                   onTap: () {},
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.edit, color: Colors.yellow),
//                       const SizedBox(width: 10),
//                       Text('Edit Post'),
//                     ],
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'Value2',
//                 child: InkWell(
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.delete, color: Colors.red),
//                       const SizedBox(width: 10),
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
//                           postid, typevalue, _keyLoadercomment, context);
//                       Navigator.pop(context);
//                       _categoryDetailsBloc = CategoryDetailsBloc(
//                           widget.groupid!, _keyLoader, context);
//                     });
//                   },
//                   child: Row(
//                     children: <Widget>[
//                       typevalue == '0'
//                           ? Icon(Icons.speaker_notes_off_outlined,
//                               color: Colors.blue)
//                           : Icon(Icons.comment_outlined, color: Colors.blue),
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
//                       PinPostBloc(postid, _keyLoaderpin, context);
//                       Navigator.pop(context);

//                       _categoryDetailsBloc = CategoryDetailsBloc(
//                           widget.groupid!, _keyLoader, context);
//                     });
//                   },
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.push_pin, color: Colors.cyanAccent),
//                       const SizedBox(width: 10),
//                       pintype == true ? Text('Unpin post') : Text('Pin Post'),
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
//           margin: EdgeInsets.only(right: 10, top: 10),
//           child: Icon(Icons.more_horiz),
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
//                     children: <Widget>[
//                       Icon(Icons.flag_outlined, color: Colors.yellow),
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
//                     showAlertDialogForHide(context: context, postid: postid);
//                   },
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.remove_red_eye, color: Colors.red),
//                       const SizedBox(width: 10),
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
//         style: GoogleFonts.reemKufi(fontSize: 14.0, color: Colors.black),
//       ),
//       onPressed: () {
//         Navigator.pop(context, false);
//       },
//     );
//     Widget continueButton = MaterialButton(
//       child: Text(
//         "Yes",
//         style: GoogleFonts.reemKufi(fontSize: 14.0, color: Colors.black),
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
//                       margin: EdgeInsets.only(bottom: 10),
//                       decoration: BoxDecoration(
//                           color: kWhite,
//                           borderRadius: BorderRadius.only(
//                               bottomRight: Radius.circular(25),
//                               bottomLeft: Radius.circular(25))),
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
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
//                         gradient: LinearGradient(
//                             colors: [kThemeColorBlue, kThemeColorGreen])),
//                     child: Padding(
//                       padding: const EdgeInsets.all(0.8),
//                       child: TextField(
//                         controller: reportTextController,
//                         keyboardType: TextInputType.emailAddress,
//                         style: GoogleFonts.reemKufi(
//                             fontWeight: FontWeight.w400, fontSize: 12),
//                         decoration: InputDecoration(
//                           fillColor: kWhite,
//                           filled: true,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           disabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.transparent, width: 1.0),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           contentPadding: const EdgeInsets.all(8.0),
//                           hintText: 'type somthing....',
//                           labelStyle: GoogleFonts.reemKufi(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
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
//                           child: Center(
//                             child: Text('Cancel'),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
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
//                           child: Center(
//                             child: Text('Report'),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
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
//         style: GoogleFonts.reemKufi(fontSize: 14.0, color: Colors.black),
//       ),
//       onPressed: () {
//         Navigator.pop(context, false);
//       },
//     );
//     Widget continueButton = MaterialButton(
//       child: Text(
//         "Yes",
//         style: GoogleFonts.reemKufi(fontSize: 14.0, color: Colors.black),
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
