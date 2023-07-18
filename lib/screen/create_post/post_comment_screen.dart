// import 'dart:developer';
// import 'dart:io';

// import 'package:bettersolver/bloc/comment_post_bloc.dart';
// import 'package:bettersolver/bloc/home_comment_list_bloc.dart';
// import 'package:bettersolver/models/home_comment_list_model.dart';
// import 'package:bettersolver/screen/home_screen_controller.dart';
// import 'package:bettersolver/style/constants.dart';
// import 'package:bettersolver/style/palette.dart';
// import 'package:bettersolver/utils/base_constant.dart';
// import 'package:bettersolver/utils/loading.dart';
// import 'package:bettersolver/utils/response.dart';
// import 'package:bettersolver/widgets/loading_dialogue.dart';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:path/path.dart' as p;

// class CommentScreen extends StatefulWidget {
//   var commentdata;

//   CommentScreen({this.commentdata});

//   @override
//   State<CommentScreen> createState() => _CommentScreenState();
// }

// class _CommentScreenState extends State<CommentScreen> {
//   @override
//   void dispose() {
//     print('CommentPostSCreen Disposed');
//     HomeScreenController _ = Get.find();
//     _.fetchallpost(_.pageno);

//     print("didChange");
//     super.dispose();
//   }

//   bool isreply = true;
//   bool liked = false;
//   List isboollikeList = [];

//   TextEditingController commentController = TextEditingController();

//   HomeCommentListBloc? homeCommentListBloc;

//   GlobalKey<State> _keyLoader = new GlobalKey<State>();
//   GlobalKey<State> _keyLoaderpop = new GlobalKey<State>();

//   List postcomment = [];

//   Map<int, dynamic> replycommentList = {};

//   List commentList = [];

//   String? postid;

//   // List _replyCommentBoolList = [];

//   List boolVisibleList = [];

//   String selectimg = '';
//   String _imgFilePath = '';
//   String _imgFileName = '';
//   String _imgFileFormate = '';
//   String _logoImg = '';

//   String? flag;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     log(widget.commentdata.toString());
//     postid = widget.commentdata['post_id'];
//     postcomment = widget.commentdata['get_post_comments'];
//     print('-postcomment ---- $postcomment');

//     // homeCommentListBloc = HomeCommentListBloc(postid!, _keyLoader, context);

//     // String countryCode = 'us';
//     // flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
//     //     (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
//     // print('Us_flag::::::::::::::::::$flag');
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future<bool> _willPopCallback() async {
//       Navigator.pop(context);
//       return true;
//     }

//     return WillPopScope(
//       onWillPop: _willPopCallback,
//       child: Scaffold(
//           backgroundColor: kWhite,
//           appBar: AppBar(
//             elevation: 0,
//             centerTitle: true,
//             backgroundColor: kWhite,
//             title: Text(
//               'COMMENTS',
//               style: Palette.greytext20B,
//             ),
//           ),
//           body: StreamBuilder(
//               stream: homeCommentListBloc!.homeCommentBlocDataStream,
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 if (snapshot.hasData) {
//                   switch (snapshot.data.status) {
//                     case Status.LOADING:
//                       return Loading(loadingMessage: snapshot.data.message);
//                       break;
//                     case Status.COMPLETED:
//                       return _mainView(snapshot.data.data);
//                       break;
//                     case Status.ERROR:
//                       return Text(
//                         'Errror msg',
//                       );
//                       break;
//                   }
//                 }
//                 return Container();
//               })),
//     );
//   }

//   Widget _mainView(HomeCommentListModel commonDataModel) {
//     return Stack(
//       children: [
//         Container(
//           height: 30,
//           decoration: Palette.loginGradient,
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 10),
//             decoration: const BoxDecoration(
//                 color: kWhite,
//                 borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(25),
//                     bottomLeft: Radius.circular(25))),
//           ),
//         ),
//         Container(
//             margin:
//                 const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 85),
//             child: _commentList(commonDataModel)),
//         Container(
//           // alignment: Alignment.bottomCenter,
//           child: Stack(
//             // mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: kWhite,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(25),
//                         topRight: Radius.circular(25),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withAlpha(20),
//                           spreadRadius: 3,
//                           blurRadius: 7,
//                           offset: const Offset(0, -7),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               height: 40,
//                               margin: const EdgeInsets.only(left: 5, right: 5),
//                               child: TextField(
//                                 controller: commentController,
//                                 keyboardType: TextInputType.text,
//                                 decoration: InputDecoration(
//                                   hintText: "Write message…",
//                                   filled: true,
//                                   fillColor: kThemeColorLightGrey,
//                                   hintStyle: Palette.greytext12,
//                                   contentPadding: const EdgeInsets.all(10),
//                                   labelStyle:
//                                       GoogleFonts.reemKufi(color: Color(0xFF424242)),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                         color: Colors.transparent, width: 1),
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                         color: Colors.transparent, width: 1),
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // InkWell(
//                           //   onTap: () {
//                           //     setState(() {
//                           //       getImgFilePath();
//                           //     });
//                           //   },
//                           //   child: Container(
//                           //     height: 50,
//                           //     width: 50,
//                           //     decoration: BoxDecoration(
//                           //         color: kWhite,
//                           //         borderRadius: BorderRadius.circular(30),
//                           //         image: DecorationImage(
//                           //             image: AssetImage(
//                           //                 'assets/images/photoicon.png'))),
//                           //   ),
//                           // ),
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 if (commentController.text.isEmpty) {
//                                   // PopBackDialouge.showDialogue(
//                                   //     context, _keyLoaderpop, 'Write comment');
//                                 } else {
//                                   LoadingDialog.showLoadingDialog(
//                                       context, _keyLoader);
//                                   CommentPostBloc(
//                                       postid!,
//                                       commentController.text,
//                                       _keyLoader,
//                                       context, onSuccess: () {
//                                     setState(() {
//                                       homeCommentListBloc = HomeCommentListBloc(
//                                           postid!, _keyLoader, context);
//                                       print('onSuccess:::::::::::::');
//                                       commentController.clear();
//                                     });
//                                   });
//                                 }
//                               });
//                             },
//                             child: Container(
//                               height: 35,
//                               width: 35,
//                               margin:
//                                   const EdgeInsets.only(right: 10, left: 10),
//                               decoration: Palette.buttonGradient,
//                               child: const Icon(
//                                 Icons.send_rounded,
//                                 color: kWhite,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//               ),
//               Visibility(
//                   visible: _imgFilePath != '',
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Expanded(child: SizedBox()),
//                       Container(
//                         height: 150,
//                         width: 150,
//                         child:
//                             _imgFilePath != null && _imgFileFormate == '.jpg' ||
//                                     _imgFileFormate == '.png' ||
//                                     _imgFileFormate == '.jpeg'
//                                 ? InkWell(
//                                     onTap: () {
//                                       //getImgFilePath();
//                                     },
//                                     child: Container(
//                                       // height: 130.0,
//                                       // width: 130.0,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(25),
//                                       ),
//                                       child: Image.file(
//                                         File(_imgFilePath),
//                                         fit: BoxFit.fill,
//                                       ),
//                                     ),
//                                   )
//                                 : InkWell(
//                                     onTap: () {
//                                       // getImgFilePath();
//                                     },
//                                     child: CircleAvatar(
//                                       radius: 60,
//                                       backgroundColor: kWhite,
//                                       backgroundImage: CachedNetworkImageProvider(_logoImg),
//                                     ),
//                                   ),
//                       ),
//                       Expanded(
//                           child: IconButton(
//                               alignment: Alignment.topCenter,
//                               onPressed: () {
//                                 setState(() {
//                                   _imgFilePath = '';
//                                 });
//                               },
//                               icon: const Icon(
//                                 Icons.clear,
//                                 color: kred,
//                                 size: 30,
//                               )))
//                     ],
//                   )),
//               Visibility(
//                   visible: _imgFilePath != '',
//                   child: const SizedBox(
//                     height: 30,
//                   ))
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // void getImgFilePath() async {
//   //   try {
//   //     String filePath = await FilePicker.getFilePath();
//   //     // String filePath = await FilePicker.
//   //
//   //     if (filePath == '') {
//   //       return;
//   //     }
//   //     print("File path: " + filePath);
//   //     setState(() {
//   //       _imgFilePath = filePath;
//   //
//   //       final _extension = p.extension(filePath, 2);
//   //       this._imgFileFormate = _extension;
//   //
//   //       print(':::::::::::::::::$_imgFilePath:::::::::::::::');
//   //       print(':::::::::::::::::$_extension:::::::::::::::');
//   //
//   //       _imgFileName = filePath.split('/').last;
//   //       print(':::::::::::::::::$_imgFileName:::::::::::::::');
//   //
//   //       //_uploadImage();
//   //     });
//   //   } on PlatformException catch (e) {
//   //     print("Error while picking the file: " + e.toString());
//   //   }
//   // }

//   void getImgFilePath() async {
//     try {
//       // String filePath = (await FilePicker.platform) as String;
//       // FilePickerResult? filePath = await FilePicker.platform.pickFiles(type: FileType.image);
//       var _file = await FilePicker.platform.pickFiles();
//       var file = _file!.files.first.name;
//       var filepath = _file.files.first.path;

//       if (filepath == '') {
//         return;
//       }
//       print("File path-+++++++++++++++++++++--:  $file");
//       print("File path--------------------------:  $filepath");
//       setState(() {
//         _imgFilePath = filepath!;
//         _imgFileName = file!;

//         final _extension = p.extension(filepath, 2);
//         this._imgFileFormate = _extension;

//         _imgFileName = filepath.split('/').last;

//         print('===============$_imgFilePath');

//         //_uploadImage();
//       });
//     } on PlatformException catch (e) {
//       print("Error while picking the file: " + e.toString());
//     }
//   }

//   Widget _commentList(HomeCommentListModel commonDataModel) {
//     print("Comments Received");
//     commentList = commonDataModel.post_data != null
//         ? commonDataModel.post_data['get_post_comments']
//         : [];

//     return ListView.builder(
//         itemCount: commentList.length != null ? commentList.length : 0,
//         shrinkWrap: true,
//         primary: false,
//         itemBuilder: (Context, index) {
//           String profilephoto = commentList[index]['publisher']['avatar'];
//           // String username = commentList[index]['publisher']['username'];
//           String fName = commentList[index]['publisher']['first_name'];
//           String lName = commentList[index]['publisher']['last_name'];

//           liked = commentList[index]['reaction']['is_reacted'];
//           String commenttext = commentList[index]['text'];
//           replycommentList[index] = commentList[index]['comment_replay'];
//           // print('replycommentList --- $replycommentList');

//           isboollikeList.add(liked);
//           List<bool> replyVisible =
//               List.generate(commentList.length, (index) => false);

//           // for (int i = 0; i < commentList.length; i++) {
//           //   print(replycommentList[i] == null);
//           //   replycommentList[i] == null
//           //       ? _replyCommentBoolList.add(false)
//           //       : _replyCommentBoolList.add(true);
//           // }

//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CircleAvatar(
//                       radius: 25,
//                       backgroundImage: CachedNetworkImageProvider(profilephoto),
//                     ),
//                     const SizedBox(
//                       width: 15,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Text(
//                             '$fName $lName',
//                             style: Palette.blacktext14,
//                           ),
//                           const SizedBox(
//                             height: 3,
//                           ),
//                           Text(
//                             '$commenttext',
//                             style: Palette.blackText12.copyWith(fontSize: 14),
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             children: [
//                               // Text(
//                               //   '6 m',
//                               //   style: Palette.blackText12,
//                               // ),
//                               InkWell(
//                                   onTap: () {
//                                     replyVisible[index] = !replyVisible[index];
//                                     // _replyCommentBoolList =
//                                     //     _replyCommentBoolList
//                                     //         .map<bool>((v) => false)
//                                     //         .toList();
//                                     // _replyCommentBoolList[index] =
//                                     //     !_replyCommentBoolList[index];
//                                     // isreply = !isreply;
//                                   },
//                                   child: Text(
//                                     replycommentList[index] != null
//                                         ? "${replycommentList[index].length} Replies"
//                                         : 'Reply',
//                                     style: Palette.blacktext10,
//                                   )),
//                               const SizedBox(
//                                 width: 15,
//                               ),
//                               // Text(
//                               //   'Edit',
//                               //   style: Palette.blacktext10,
//                               // )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             isboollikeList[index] = !isboollikeList[index];
//                           });
//                         },
//                         child: liked == isboollikeList[index]
//                             ? const Icon(
//                                 Icons.favorite_outline,
//                                 color: kGreyone,
//                               )
//                             : Icon(
//                                 Icons.favorite,
//                                 color: kred,
//                               ))
//                   ],
//                 ),
//               ),
//               Visibility(
//                   visible: replyVisible[index],
//                   child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           ListView.builder(
//                               itemCount: replycommentList != null
//                                   ? replycommentList.length
//                                   : 0,
//                               shrinkWrap: true,
//                               primary: false,
//                               itemBuilder: (Context, i) {
//                                 String profileimage = replycommentList[index][i]
//                                     ['publisher']['avatar'];
//                                 String username = replycommentList[index][i]
//                                     ['publisher']['username'];
//                                 String comment =
//                                     replycommentList[index][i]['Orginaltext'];
//                                 String imageUrl =
//                                     replycommentList[index][i]['c_file'];

//                                 for (int i = 0;
//                                     i < replycommentList.length;
//                                     i++) {
//                                   boolVisibleList.add(false);
//                                 }

//                                 if (replycommentList[index][i]['c_file'] !=
//                                     null) {
//                                   is_reply = true;
//                                 }
//                                 return Column(
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 20, right: 20, top: 2),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 15,
//                                             backgroundImage:
//                                                 CachedNetworkImageProvider(profileimage),
//                                           ),
//                                           const SizedBox(
//                                             width: 15,
//                                           ),
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 Text(
//                                                   username,
//                                                   style: Palette.blacktext14,
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 Text(
//                                                   comment,
//                                                   style: Palette.blackText12,
//                                                 ),
//                                                 imageUrl != null
//                                                     ? Container(
//                                                         height: 200,
//                                                         margin: const EdgeInsets
//                                                                 .only(
//                                                             top: 5, bottom: 5),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                                 // color: Colors.black,
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             15),
//                                                                 image: DecorationImage(
//                                                                     image: CachedNetworkImageProvider(BaseConstant
//                                                                             .BASE_URL_DEMO +
//                                                                         replycommentList[index][i]
//                                                                             [
//                                                                             'c_file']),
//                                                                     fit: BoxFit
//                                                                         .contain)),
//                                                       )
//                                                     : Container(
//                                                         height: 0,
//                                                       ),
//                                                 const SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Text(
//                                                       '6 m',
//                                                       style:
//                                                           Palette.blackText12,
//                                                     ),
//                                                     const SizedBox(
//                                                       width: 15,
//                                                     ),
//                                                     const Icon(
//                                                       Icons.edit,
//                                                       size: 11,
//                                                       color: Colors.black38,
//                                                     ),
//                                                     const SizedBox(
//                                                       width: 7,
//                                                     ),
//                                                     const Icon(
//                                                       Icons.delete,
//                                                       size: 11,
//                                                       color: Colors.black38,
//                                                     )
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 10,
//                                             width: 10,
//                                             margin: const EdgeInsets.only(
//                                                 right: 10),
//                                             decoration: const BoxDecoration(
//                                                 image: DecorationImage(
//                                                     image: AssetImage(
//                                                         'assets/images/likeicon.png'))),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 );
//                               }),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   height: 40,
//                                   margin:
//                                       const EdgeInsets.only(left: 60, right: 5),
//                                   child: TextField(
//                                     controller: commentController,
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       hintText: "Write message…",
//                                       filled: true,
//                                       fillColor: kThemeColorLightGrey,
//                                       hintStyle: Palette.greytext12,
//                                       contentPadding: const EdgeInsets.all(10),
//                                       labelStyle: GoogleFonts.reemKufi(
//                                           color: const Color(0xFF424242)),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: const BorderSide(
//                                             color: Colors.transparent,
//                                             width: 1),
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: const BorderSide(
//                                             color: Colors.transparent,
//                                             width: 1),
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // InkWell(
//                               //   onTap: () {
//                               //     setState(() {
//                               //       getImgFilePath();
//                               //     });
//                               //   },
//                               //   child: Container(
//                               //     height: 50,
//                               //     width: 50,
//                               //     decoration: BoxDecoration(
//                               //         color: kWhite,
//                               //         borderRadius: BorderRadius.circular(30),
//                               //         image: DecorationImage(
//                               //             image: AssetImage(
//                               //                 'assets/images/photoicon.png'))),
//                               //   ),
//                               // ),
//                               InkWell(
//                                 onTap: () {},
//                                 child: Container(
//                                   height: 35,
//                                   width: 35,
//                                   margin: const EdgeInsets.only(
//                                       right: 10, left: 10),
//                                   decoration: Palette.buttonGradient,
//                                   child: const Icon(
//                                     Icons.send_rounded,
//                                     color: kWhite,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ))),
//               const SizedBox(
//                 height: 10,
//               ),
//             ],
//           );
//         });
//   }

//   bool is_reply = false;
// }
