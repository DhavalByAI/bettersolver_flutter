import 'package:bettersolver/bloc/home_comment_list_bloc.dart';
import 'package:bettersolver/screen/create_post/post_comment_controller.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/base_constant.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen_controller.dart';

class CommentScreen extends StatefulWidget {
  var commentdata;

  CommentScreen({super.key, this.commentdata});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final PostCommentController _ = Get.put(PostCommentController());
  TextEditingController commentController = TextEditingController();
  TextEditingController commentReplyController = TextEditingController();
  TextEditingController editReplyController = TextEditingController();
  TextEditingController editCommentController = TextEditingController();

  Map<int, dynamic> replycommentList = {};
  List commentList = [];

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderpop = GlobalKey<State>();
  HomeCommentListBloc? homeCommentListBloc;
  String? myUserID;
  bool autoF = false;
  @override
  void initState() {
    _.commentData = widget.commentdata;
    shared();
    super.initState();
  }

  shared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    myUserID = pref.getString('userid');
    setState(() {});
  }

  @override
  void dispose() {
    print('CommentPostSCreen Disposed');
    HomeScreenController c = Get.find();
    c.fetchallpost(c.pageno);
    _.clearVariable();
    super.dispose();
  }

  Future<bool> _willPopCallback() async {
    Get.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
          backgroundColor: kWhite,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: kWhite,
            title: Text(
              'COMMENTS',
              style: Palette.greytext20B,
            ),
          ),
          body: _mainView(),
        ));
  }

  Widget _mainView() {
    return Stack(
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
            margin:
                const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 85),
            child: _commentList()),
        Container(
          // alignment: Alignment.bottomCenter,
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, -7),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: TextField(
                                controller: commentController,
                                keyboardType: TextInputType.text,
                                autofocus: autoF,
                                decoration: InputDecoration(
                                  hintText: "Write message…",
                                  filled: true,
                                  fillColor: kThemeColorLightGrey,
                                  hintStyle: Palette.greytext12,
                                  contentPadding: const EdgeInsets.all(10),
                                  labelStyle: GoogleFonts.roboto(
                                      color: const Color(0xFF424242)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 1),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 1),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       getImgFilePath();
                          //     });
                          //   },
                          //   child: Container(
                          //     height: 50,
                          //     width: 50,
                          //     decoration: BoxDecoration(
                          //         color: kWhite,
                          //         borderRadius: BorderRadius.circular(30),
                          //         image: DecorationImage(
                          //             image: AssetImage(
                          //                 'assets/images/photoicon.png'))),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () {
                              _.CommentPost(
                                  postid: _.commentData['post_id'],
                                  commenttext: commentController.text);
                              commentController.clear();
                              // setState(() {
                              //   if (commentController.text.isEmpty) {
                              //     PopBackDialouge.showDialogue(
                              //         context, _keyLoaderpop, 'Write comment');
                              //   } else {
                              //     LoadingDialog.showLoadingDialog(
                              //         context, _keyLoader);
                              //     CommentPostBloc(
                              //         widget.commentdata['post_id'],
                              //         commentController.text,
                              //         _keyLoader,
                              //         context, onSuccess: () {
                              //       setState(() {
                              //         homeCommentListBloc = HomeCommentListBloc(
                              //             widget.commentdata['post_id'],
                              //             _keyLoader,
                              //             context);
                              //         print('onSuccess:::::::::::::');
                              //         commentController.clear();
                              //       });
                              //     });
                              //   }
                              // });
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              margin:
                                  const EdgeInsets.only(right: 10, left: 10),
                              decoration: Palette.buttonGradient,
                              child: const Icon(
                                Icons.send_rounded,
                                color: kWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              // Visibility(
              //     visible: _imgFilePath != '',
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Expanded(child: SizedBox()),
              //         Container(
              //           height: 150,
              //           width: 150,
              //           child:
              //               _imgFilePath != null && _imgFileFormate == '.jpg' ||
              //                       _imgFileFormate == '.png' ||
              //                       _imgFileFormate == '.jpeg'
              //                   ? InkWell(
              //                       onTap: () {
              //                         //getImgFilePath();
              //                       },
              //                       child: Container(
              //                         // height: 130.0,
              //                         // width: 130.0,
              //                         decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(25),
              //                         ),
              //                         child: Image.file(
              //                           File(_imgFilePath),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                   : InkWell(
              //                       onTap: () {
              //                         // getImgFilePath();
              //                       },
              //                       child: CircleAvatar(
              //                         radius: 60,
              //                         backgroundColor: kWhite,
              //                         backgroundImage: CachedNetworkImageProvider(_logoImg),
              //                       ),
              //                     ),
              //         ),
              //         Expanded(
              //             child: IconButton(
              //                 alignment: Alignment.topCenter,
              //                 onPressed: () {
              //                   setState(() {
              //                     _imgFilePath = '';
              //                   });
              //                 },
              //                 icon: const Icon(
              //                   Icons.clear,
              //                   color: kred,
              //                   size: 30,
              //                 )))
              //       ],
              //     )),
              // Visibility(
              //     visible: _imgFilePath != '',
              //     child: const SizedBox(
              //       height: 30,
              //     ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _commentList() {
    return GetBuilder<PostCommentController>(
      initState: (_) {},
      builder: (_) {
        commentList = _.commentData['get_post_comments'] ?? [];
        return ListView.builder(
            itemCount: commentList.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (Context, index) {
              // String profilephoto = commentList[index]['publisher']['avatar'];
              // // String username = commentList[index]['publisher']['username'];
              // String fName = commentList[index]['publisher']['first_name'];
              // String lName = commentList[index]['publisher']['last_name'];

              // bool liked = commentList[index]['reaction']['is_reacted'];
              // String commenttext = commentList[index]['text'];

              // // print('replycommentList --- ');

              // List<bool> isboollikeList = [];
              String postID = _.commentData['post_id'];

              _.isboollikeList
                  .add(commentList[index]['reaction']['is_reacted']);

              // for (int i = 0; i < commentList.length; i++) {
              //   print(replycommentList[i] == null);
              //   replycommentList[i] == null
              //       ? _replyCommentBoolList.add(false)
              //       : _replyCommentBoolList.add(true);
              // }
              replycommentList[index] = commentList[index]['comment_replay'];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(
                              commentList[index]['publisher']['avatar']),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${commentList[index]['publisher']['first_name']} ${commentList[index]['publisher']['last_name']}',
                                style: Palette.blacktext14,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: _.isCommentEdit[index]
                                        ? editCommentField(
                                            commentID: commentList[index]['id'],
                                            postID: commentList[index]
                                                ['post_id'])
                                        : Text(
                                            '${commentList[index]['text']}',
                                            style: Palette.blackText12
                                                .copyWith(fontSize: 14),
                                          ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  // Text(
                                  //   '6 m',
                                  //   style: Palette.blackText12,
                                  // ),
                                  InkWell(
                                      onTap: () {
                                        _.replyVisible[index] =
                                            !_.replyVisible[index];
                                        for (int i = 0;
                                            i < _.replyVisible.length;
                                            i++) {
                                          i == index
                                              ? null
                                              : _.replyVisible[i] = false;
                                        }
                                        _.update();
                                        print(
                                            "showing Reply Comments ${_.replyVisible[index]}");
                                        // _replyCommentBoolList =
                                        //     _replyCommentBoolList
                                        //         .map<bool>((v) => false)
                                        //         .toList();
                                        // _replyCommentBoolList[index] =
                                        //     !_replyCommentBoolList[index];
                                        // isreply = !isreply;
                                      },
                                      child: Text(
                                        replycommentList[index] != null ||
                                                replycommentList[index]
                                                        .length !=
                                                    0
                                            ? "${replycommentList[index].length} Replies"
                                            : 'Reply',
                                        style: Palette.blacktext10,
                                      )),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  myUserID == commentList[index]['user_id']
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                editCommentController.text =
                                                    commentList[index]['text'];
                                                _.isCommentEdit[index] =
                                                    !_.isCommentEdit[index];
                                                for (int j = 0;
                                                    j < _.isCommentEdit.length;
                                                    j++) {
                                                  j == index
                                                      ? null
                                                      : _.isCommentEdit[j] =
                                                          false;
                                                }
                                                _.update();
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                size: 11,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _.deleteComment(
                                                    comment_id:
                                                        commentList[index]
                                                            ['id'],
                                                    postid: postID);
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                size: 11,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () {
                                            _.reportComment(
                                                commentList[index]['id'],
                                                commentList[index]['post_id']);
                                          },
                                          child: Icon(
                                            Icons.report,
                                            size: 12,
                                            color: commentList[index]
                                                        ['is_comment_report'] ==
                                                    1
                                                ? Colors.redAccent
                                                : Colors.black54,
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GetBuilder<PostCommentController>(
                          initState: (_) {},
                          builder: (_) {
                            return GestureDetector(
                                onTap: () {
                                  _.isboollikeList[index] =
                                      !_.isboollikeList[index];
                                  _.update();
                                },
                                child: !_.isboollikeList[index]
                                    ? const Icon(
                                        Icons.favorite_outline,
                                        color: kGreyone,
                                      )
                                    : const Icon(
                                        Icons.favorite,
                                        color: kred,
                                      ));
                          },
                        )
                      ],
                    ),
                  ),
                  GetBuilder<PostCommentController>(
                    initState: (_) {},
                    builder: (_) {
                      print(_.replyVisible[index]);
                      return Visibility(
                        visible: _.replyVisible[index],
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListView.builder(
                                    itemCount: replycommentList[index] !=
                                                null ||
                                            replycommentList[index].length != 0
                                        ? replycommentList[index].length
                                        : 0,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (Context, i) {
                                      // String profileimage = replycommentList[index]
                                      //     [i]['publisher']['avatar'];
                                      // String username = replycommentList[index][i]
                                      //     ['publisher']['username'];
                                      // String comment =
                                      //     replycommentList[index][i]['Orginaltext'];
                                      // String imageUrl =
                                      //     replycommentList[index][i]['c_file'];

                                      // for (int i = 0; i < replycommentList.length; i++) {
                                      //   boolVisibleList.add(false);
                                      // }

                                      // if (replycommentList[index][i]['c_file'] != null) {
                                      //   is_reply = true;
                                      // }

                                      return Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 20, right: 20, top: 2),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                          replycommentList[
                                                                      index][i]
                                                                  ['publisher']
                                                              ['avatar']),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '${replycommentList[index][i]['publisher']['first_name']} ${replycommentList[index][i]['publisher']['last_name']}',
                                                        style:
                                                            Palette.blacktext14,
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      _.isReplyEdit[i]
                                                          ? editReplyField(
                                                              commentID:
                                                                  replycommentList[
                                                                          index]
                                                                      [i]['id'],
                                                              postID: postID)
                                                          : Text(
                                                              replycommentList[
                                                                      index][i]
                                                                  ['text'],
                                                              style: Palette
                                                                  .blackText12,
                                                            ),
                                                      replycommentList[index][i]
                                                                  ['c_file'] !=
                                                              ""
                                                          ? Container(
                                                              height: 200,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      // color: Colors.black,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      image: DecorationImage(
                                                                          image:
                                                                              CachedNetworkImageProvider(BaseConstant.BASE_URL_DEMO + replycommentList[index][i]['c_file']),
                                                                          fit: BoxFit.contain)),
                                                            )
                                                          : const SizedBox(),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            formatTimeDifference(
                                                                replycommentList[
                                                                        index][
                                                                    i]['time']),
                                                            style: Palette
                                                                .blackText12,
                                                          ),
                                                          myUserID ==
                                                                  replycommentList[index]
                                                                              [
                                                                              i]
                                                                          [
                                                                          'publisher']
                                                                      [
                                                                      'user_id']
                                                              ? Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        _.isReplyEdit[
                                                                            i] = !_
                                                                                .isReplyEdit[
                                                                            i];
                                                                        for (int j =
                                                                                0;
                                                                            j < _.isReplyEdit.length;
                                                                            j++) {
                                                                          j == i
                                                                              ? null
                                                                              : _.isReplyEdit[j] = false;
                                                                        }

                                                                        editReplyController
                                                                            .text = replycommentList[index]
                                                                                [i]
                                                                            [
                                                                            'text'];

                                                                        _.update();
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .edit,
                                                                        size:
                                                                            11,
                                                                        color: Colors
                                                                            .black38,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 7,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        _.deleteCommentReply(
                                                                            comment_id:
                                                                                replycommentList[index][i]['id'],
                                                                            postid: postID);
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .delete,
                                                                        size:
                                                                            11,
                                                                        color: Colors
                                                                            .black38,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              : const SizedBox()
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/likeicon.png'))),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      );
                                    }),
                                replyCommentField(
                                  c: _,
                                  index: index,
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            });
      },
    );
  }

  Row editCommentField({required String commentID, required String postID}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: editCommentController,
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Write message…",
                filled: true,
                fillColor: Colors.grey[100], //kThemeColorLightGrey,
                hintStyle: Palette.greytext12,
                contentPadding: const EdgeInsets.all(10),
                labelStyle: GoogleFonts.roboto(color: const Color(0xFF424242)),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            EasyLoading.show();
            _.CommentPost(
                postid: postID,
                commenttext: editCommentController.text,
                commentId: commentID,
                isEdit: true);
            // _.EditCommentReply(
            //     comment_id: commentID,
            //     postid: postID,
            //     text: editReplyController.text);
          },
          child: Container(
            height: 35,
            width: 35,
            margin: const EdgeInsets.only(right: 10, left: 10),
            decoration: Palette.buttonGradient,
            child: const Icon(
              Icons.send_rounded,
              color: kWhite,
            ),
          ),
        ),
      ],
    );
  }

  Row editReplyField({required String commentID, required String postID}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: editReplyController,
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Write message…",
                filled: true,
                fillColor: Colors.grey[100], //kThemeColorLightGrey,
                hintStyle: Palette.greytext12,
                contentPadding: const EdgeInsets.all(10),
                labelStyle: GoogleFonts.roboto(color: const Color(0xFF424242)),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            EasyLoading.show();
            _.EditCommentReply(
                comment_id: commentID,
                postid: postID,
                text: editReplyController.text);
          },
          child: Container(
            height: 35,
            width: 35,
            margin: const EdgeInsets.only(right: 10, left: 10),
            decoration: Palette.buttonGradient,
            child: const Icon(
              Icons.send_rounded,
              color: kWhite,
            ),
          ),
        ),
      ],
    );
  }

  Row replyCommentField(
      {required PostCommentController c, required int index, double? width}) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            width: width,
            margin: const EdgeInsets.only(left: 60, right: 5),
            child: TextField(
              controller: commentReplyController,
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Write message…",
                filled: true,
                fillColor: kThemeColorLightGrey,
                hintStyle: Palette.greytext12,
                contentPadding: const EdgeInsets.all(10),
                labelStyle: GoogleFonts.roboto(color: const Color(0xFF424242)),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     setState(() {
        //       getImgFilePath();
        //     });
        //   },
        //   child: Container(
        //     height: 50,
        //     width: 50,
        //     decoration: BoxDecoration(
        //         color: kWhite,
        //         borderRadius: BorderRadius.circular(30),
        //         image: DecorationImage(
        //             image: AssetImage(
        //                 'assets/images/photoicon.png'))),
        //   ),
        // ),
        InkWell(
          onTap: () {
            EasyLoading.show();
            c.postCommentReply(
                comment_id: commentList[index]['id'],
                post_id: commentList[index]['post_id'],
                text: commentReplyController.text);
            commentReplyController.clear();
          },
          child: Container(
            height: 35,
            width: 35,
            margin: const EdgeInsets.only(right: 10, left: 10),
            decoration: Palette.buttonGradient,
            child: const Icon(
              Icons.send_rounded,
              color: kWhite,
            ),
          ),
        ),
      ],
    );
  }

  String formatTimeDifference(String timeString) {
    DateTime now = DateTime.now();
    DateTime time =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timeString) * 1000);

    Duration difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'min' : 'min'} ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else {
      // Format the date using the intl package
      final formatter = DateFormat('MMM dd, yyyy');
      return formatter.format(time);
    }
  }
}
