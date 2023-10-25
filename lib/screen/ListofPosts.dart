import 'dart:developer';
import 'package:bettersolver/bloc/delete_post_bloc.dart';
import 'package:bettersolver/bloc/enable_disable_comment_bloc.dart';
import 'package:bettersolver/bloc/hide_post_bloc.dart';
import 'package:bettersolver/bloc/liked_bloc.dart';
import 'package:bettersolver/bloc/saved_post_bloc.dart';
import 'package:bettersolver/models/all_post_model.dart';
import 'package:bettersolver/screen/ListOfPosts_controller.dart';
import 'package:bettersolver/screen/create_post/create_post_controller.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/apiprovider.dart';
import 'package:bettersolver/utils/base_constant.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_polls/simple_polls.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/edit_post_bloc.dart';
import '../bloc/report_post_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'auth/login.dart';
import 'create_post/get_post_comment_screen.dart';
import 'msg_group_chat/message_screen.dart';
import 'profile/video_player.dart';
import 'profile_screen.dart';
import 'viewprofile/viewprofile_screen.dart';

class ListOfPosts extends StatefulWidget {
  List posts;
  String url;
  RefreshController refreshController;
  ScrollController? sc;
  bool? isAppbar;
  ListOfPosts(
      {super.key,
      required this.posts,
      required this.url,
      this.sc,
      this.isAppbar,
      required this.refreshController});

  @override
  State<ListOfPosts> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListOfPosts> {
  @override
  void dispose() {
    log("ListOfPosts Disposed");
    super.dispose();
  }

  final ListOfPostsController _ = Get.put(ListOfPostsController());

  String? profileid;
  String? profilePic;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyLoadercomment = GlobalKey<State>();
  final GlobalKey<State> _keyLoadersavepost = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderreport = GlobalKey<State>();
  TextEditingController reportTextController = TextEditingController();

  @override
  void initState() {
    _.refreshController = widget.refreshController;
    _.url = widget.url;
    _.posts = widget.posts;
    _.fetchallpost("1", widget.url);
    shared();
    super.initState();
  }

  shared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    profilePic = pref.getString("profileimage");
    profileid = pref.getString('userid');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListOfPostsController>(
      initState: (_) {},
      builder: (_) {
        // _.islikeboollist.clear();
        // _.issavepostboollist.clear();
        // _.ispinpostList.clear();
        return Flexible(
          child: SmartRefresher(
            scrollController: widget.sc,
            controller: widget.refreshController,
            onRefresh: _.onRefresh,
            onLoading: _.onLoading,
            enablePullDown: true,
            enablePullUp: true,
            header: CustomHeader(
              builder: (context, mode) {
                if (mode == LoadStatus.idle) {
                  print("pull up load");
                } else if (mode == LoadStatus.loading) {
                  // _.fetchallpost("1");
                  print("data loading");
                  // body = CupertinoActivityIndicator();
                }

                return const SizedBox(
                    height: 50,
                    width: 50,
                    child: Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                    )));
              },
            ),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  log("idle");
                  body = const Text("pull down load");
                } else if (mode == LoadStatus.loading) {
                  log("loading");
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  log("failed");
                  body = const Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  log("can loading");
                  body = const Text("release to load more");
                } else {
                  log("no more data");
                  body = const Text("No more Data");
                }
                return ReturnOfFooter(body);
              },
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (widget.isAppbar ?? false)
                      ? Container(
                          height: 85,
                          decoration: Palette.loginGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(12)
                                .copyWith(top: 30, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('better  solver',
                                    style: GoogleFonts.reemKufi(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26,
                                      color: kWhite,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            currUser!.user_data[
                                                        'is_email_verify'] !=
                                                    '1'
                                                ? Get.dialog(Dialog(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          const Icon(
                                                            Icons.error_outline,
                                                            size: 30,
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              'Important! To access the profile, please confirm your email address in your mail inbox',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              MaterialButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      false);
                                                                  logoutUser();
                                                                },
                                                                child: const Text(
                                                                    'Logout'),
                                                              ),
                                                              const Spacer(),
                                                              MaterialButton(
                                                                onPressed:
                                                                    () {},
                                                                child: const Text(
                                                                    'Resend Email'),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                                : Get.to(() => const Profile());
                                          },
                                          child: Image.asset(
                                            'assets/images/profilewhite.png',
                                            height: 25,
                                            width: 25,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MessageScreen()));
                                          },
                                          child: Image.asset(
                                            'assets/images/messagewhite.png',
                                            height: 25,
                                            width: 25,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        _.posts != null ? _.posts.length : 0, (index) {
                      String postid = _.posts[index]['post_id'];
                      String posteduserid = _.posts[index]['user_id'];
                      String username = _.posts[index]['publisher']['username'];
                      String profileimage =
                          _.posts[index]['publisher']['avatar'];
                      String fname =
                          _.posts[index]['publisher']['first_name'] ?? '-';
                      String lname =
                          _.posts[index]['publisher']['last_name'] ?? '-';
                      String posttime = _.posts[index]['post_time'];
                      String postUserId = _.posts[index]['user_id'];
                      String commentstatus = _.posts[index]['comments_status'];
                      bool iscommentstatus = false;

                      if (commentstatus.contains("1")) {
                        iscommentstatus = true;
                      } else {
                        iscommentstatus = false;
                      }
                      //  print('Comment_statu-------');
                      String comment = _.posts[index]['post_comments'];
                      String title = _.posts[index]['title'] ?? '-';
                      int feelingType = 10;
                      int rfeelingType = 10;
                      // if (_.posts[index]['postText'].toString().startsWith('<')) {
                      //   var temp =
                      //       emojiText(_.posts[index]['postText'].toString());
                      // }
                      String postText =
                          _.posts[index]['Orginaltext'].toString();
                      postText = EmojiParser().emojify(postText);

                      String postFeelingText = '';
                      if (_.posts[index]['postFeeling'] != '') {
                        String postFeeling = _.posts[index]['postFeeling'];
                        postFeelingText = " Feeling $postFeeling";
                        feelingType = 0;
                      } else if (_.posts[index]['postListening'] != '') {
                        String postFeeling = _.posts[index]['postListening'];
                        postFeelingText = " Listening To $postFeeling";
                        feelingType = 1;
                      } else if (_.posts[index]['postTraveling'] != '') {
                        String postFeeling = _.posts[index]['postTraveling'];
                        postFeelingText = " Travelling To $postFeeling";
                        feelingType = 2;
                      } else if (_.posts[index]['postWatching'] != '') {
                        String postFeeling = _.posts[index]['postWatching'];
                        postFeelingText = " Watching $postFeeling";
                        feelingType = 3;
                      } else if (_.posts[index]['postPlaying'] != '') {
                        String postFeeling = _.posts[index]['postPlaying'];
                        postFeelingText = " Playing $postFeeling";
                        feelingType = 4;
                      }
                      String rPostFeelingText = '';
                      if (_.posts[index]['sharePostData'] != null) {
                        if (_.posts[index]['sharePostData']['postFeeling'] !=
                            '') {
                          String postFeeling =
                              _.posts[index]['sharePostData']['postFeeling'];
                          rPostFeelingText = " Feeling $postFeeling";
                          rfeelingType = 0;
                        } else if (_.posts[index]['sharePostData']
                                ['postListening'] !=
                            '') {
                          String postFeeling =
                              _.posts[index]['sharePostData']['postListening'];
                          rPostFeelingText = " Listening To $postFeeling";
                          rfeelingType = 1;
                        } else if (_.posts[index]['sharePostData']
                                ['postTraveling'] !=
                            '') {
                          String postFeeling =
                              _.posts[index]['sharePostData']['postTraveling'];
                          rPostFeelingText = " Travelling To $postFeeling";
                          rfeelingType = 2;
                        } else if (_.posts[index]['sharePostData']
                                ['postWatching'] !=
                            '') {
                          String postFeeling =
                              _.posts[index]['sharePostData']['postWatching'];
                          rPostFeelingText = " Watching $postFeeling";
                          rfeelingType = 3;
                        } else if (_.posts[index]['sharePostData']
                                ['postPlaying'] !=
                            '') {
                          String postFeeling =
                              _.posts[index]['sharePostData']['postPlaying'];
                          rPostFeelingText = " Playing $postFeeling";
                          rfeelingType = 4;
                        }
                      }

                      List feelingIcon = [
                        Icons.emoji_emotions_outlined,
                        Icons.headphones_rounded,
                        Icons.travel_explore_rounded,
                        Icons.remove_red_eye_rounded,
                        Icons.sports_basketball_rounded
                      ];
                      // .startsWith('<')
                      //     ? EmojiParser().emojify(':expressionless:')
                      //     : _.posts[index]['postText'];
                      // String postText = _.posts[index]['postText'] ?? '-';
                      String groupId = _.posts[index]['group_id'];

                      bool savepost = _.posts[index]['is_post_saved'];
                      bool liked = _.posts[index]['reaction']['is_reacted'];

                      int likecount = _.posts[index]['reaction']['count'];

                      String? shareUrl = _.posts[index]['post_url'];

                      _.islikeboollist
                          .add(_.posts[index]['reaction']['is_reacted']);
                      _.isReacting.add(false);
                      _.issavepostboollist.add(_.posts[index]['is_post_saved']);

                      var commentdata = _.posts[index];

                      var multiImage = _.posts[index]['multi_image'];
                      List? multiphoto = _.posts[index]['photo_multi'];
                      var rmultiImage;
                      List? rmultiphoto;

                      if (_.posts[index]['sharePostData'] != null) {
                        var rmultiImage =
                            _.posts[index]['sharePostData']['multi_image'];
                        List? rmultiphoto =
                            _.posts[index]['sharePostData']['photo_multi'];
                      }
                      String post = _.posts[index]['postFile_full'];

                      // String post = BaseConstant.BASE_URL_DEMO + _post;

                      String? videothumb = _.posts[index]['postFileThumb'];
                      String videothumb0 =
                          BaseConstant.BASE_URL_DEMO + videothumb!;
                      String? groupTitle = _.posts[index]['group_title'];
                      bool pinpoststatus = _.posts[index]['is_post_pinned'];
                      List options = _.posts[index]['options'];
                      _.aud.add(AudioCl(player: AudioPlayer()));
                      _.ispinpostList.add(pinpoststatus);

                      return Container(
                        color: kWhite,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            index == 0
                                ? const Divider(color: kWhite)
                                : const Divider(thickness: 5.0),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    profileid != posteduserid
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewProfileScreen(
                                                      userviewid: postUserId,
                                                    )))
                                        : null;
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    margin: const EdgeInsets.only(
                                        left: 15, top: 15),
                                    decoration: Palette.RoundGradient,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                profileimage),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GetBuilder<ListOfPostsController>(
                                        initState: (_) {},
                                        builder: (_) {
                                          for (var element in _.categoryList) {
                                            groupTitle == element['group_title']
                                                ? groupTitle = element['name']
                                                : null;
                                          }
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  profileid != posteduserid
                                                      ? Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ViewProfileScreen(
                                                                    userviewid:
                                                                        postUserId,
                                                                  )))
                                                      : null;
                                                },
                                                child: Text(
                                                  "$fname $lname",
                                                  style: Palette.blacktext16,
                                                ),
                                              ),
                                              groupTitle != null
                                                  ? const Icon(
                                                      Icons.arrow_right_rounded,
                                                      color: Colors.grey,
                                                      size: 30)
                                                  : const SizedBox(),
                                              groupTitle != null
                                                  ? Flexible(
                                                      child: Text(
                                                        groupTitle!,
                                                        style: Palette
                                                            .greytext12
                                                            .copyWith(
                                                                fontSize: 10),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          );
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {
                                          profileid != posteduserid
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewProfileScreen(
                                                            userviewid:
                                                                postUserId,
                                                          )))
                                              : null;
                                        },
                                        child: Text(
                                          "  @$username",
                                          style: Palette.greytext12
                                              .copyWith(fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          const Icon(
                                            Icons.access_time,
                                            size: 13,
                                            color: kGreyone,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              posttime,
                                              style: Palette.greytext12
                                                  .copyWith(fontSize: 10),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // _popupmenuforour(postid, iscommentstatus, pinpoststatus,
                                //     index, title, postText, group_id)

                                profileid == posteduserid
                                    ? _popupmenuforour(
                                        postid,
                                        iscommentstatus,
                                        pinpoststatus,
                                        index,
                                        title,
                                        postText,
                                        groupId)
                                    : _popupmenuForOther(postid, index)
                              ],
                            ),
                            _.posts[index]['sharePostData'] == null &&
                                    _.posts[index]['Orginaltext'] != ''
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 8, bottom: 0),
                                    child: Linkify(
                                      onOpen: (link) async {
                                        if (!await launchUrl(
                                            Uri.parse(link.url))) {
                                          throw Exception(
                                              'Could not launch ${link.url}');
                                        }
                                      },
                                      text: EmojiParser().emojify(
                                          _.posts[index]['title'].toString()),
                                      style: Palette.blacktext14B
                                          .copyWith(fontSize: 16),
                                    ),
                                    // Text(postText),here
                                  )
                                : const SizedBox(),
                            _.posts[index]['sharePostData'] == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      options.isNotEmpty && options != []
                                          ? const SizedBox()
                                          : postFeelingText != ''
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 20,
                                                      top: 6,
                                                      bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Linkify(
                                                        onOpen: (link) async {
                                                          if (!await launchUrl(
                                                              Uri.parse(
                                                                  link.url))) {
                                                            throw Exception(
                                                                'Could not launch ${link.url}');
                                                          }
                                                        },
                                                        text: postText,
                                                      ),
                                                      const Text(" - "),
                                                      feelingType != 10
                                                          ? Icon(
                                                              feelingIcon[
                                                                  feelingType],
                                                              size: 16,
                                                            )
                                                          : const SizedBox(),
                                                      Text(postFeelingText),
                                                    ],
                                                  ))
                                              : (postText != '')
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              top: 6,
                                                              bottom: 10),
                                                      child: Linkify(
                                                        onOpen: (link) async {
                                                          if (!await launchUrl(
                                                              Uri.parse(
                                                                  link.url))) {
                                                            throw Exception(
                                                                'Could not launch ${link.url}');
                                                          }
                                                        },
                                                        text: postText,
                                                      ),
                                                      // Text(postText),here
                                                    )
                                                  : const SizedBox(
                                                      height: 6,
                                                    ),
                                      post.contains(".jpeg") ||
                                              post.contains(".jpg") ||
                                              post.contains(".png")
                                          ? GestureDetector(
                                              onDoubleTap: () {
                                                // setState(() {
                                                //   _.islikeboollist[index] =
                                                //       !_.islikeboollist[index];
                                                //   if (_.islikeboollist[index] == true) {
                                                //     setState(() {
                                                //       _.posts[index]['reaction']['count']++;
                                                //     });
                                                //   } else {
                                                //     setState(() {
                                                //       _.posts[index]['reaction']['count']--;
                                                //     });
                                                //   }
                                                LikedBloc(
                                                    postid,
                                                    "2",
                                                    _.posts[index]['reaction']
                                                        ['is_reacted'],
                                                    widget.url);

                                                // });
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image:
                                                            CachedNetworkImageProvider(
                                                                post))),
                                              ),
                                            )
                                          : post.contains('.mp4')
                                              ? GestureDetector(
                                                  onDoubleTap: () async {
                                                    // setState(() {
                                                    //   _.islikeboollist[index] =
                                                    //       !_.islikeboollist[index];
                                                    //   if (_.islikeboollist[index] == true) {
                                                    //     setState(() {
                                                    //       _.posts[index]['reaction']
                                                    //           ['count']++;
                                                    //     });
                                                    //   } else {
                                                    //     setState(() {
                                                    //       _.posts[index]['reaction']
                                                    //           ['count']--;
                                                    //     });
                                                    //   }
                                                    LikedBloc(
                                                        postid,
                                                        "2",
                                                        _.posts[index]
                                                                ['reaction']
                                                            ['is_reacted'],
                                                        widget.url);

                                                    // });
                                                  },
                                                  child:
                                                      VideoPlayer(post: post))
                                              // ? VideoPost(post: _post)
                                              : multiImage == '1' && post != " "
                                                  ? SizedBox(
                                                      height: 400,
                                                      child: StaggeredGridView
                                                          .countBuilder(
                                                        // padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                                        crossAxisCount: 4,
                                                        shrinkWrap: true,

                                                        itemCount:
                                                            multiphoto!.length,
                                                        primary: true,
                                                        //shrinkWrap: false,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          String mulimage =
                                                              multiphoto[index]
                                                                  ['image'];
                                                          return InkWell(
                                                            onTap: () {
                                                              log("  multiphoto.length ${multiphoto.length}");
                                                              log("multiphoto[index]['image'] ${multiphoto[index]['image']}");
                                                              MultiImageProvider
                                                                  multiImageProvider =
                                                                  MultiImageProvider(
                                                                      List.generate(
                                                                          multiphoto
                                                                              .length,
                                                                          ((index) {
                                                                        return Image(
                                                                            image:
                                                                                CachedNetworkImageProvider(
                                                                          multiphoto[index]
                                                                              [
                                                                              'image'],
                                                                        )).image;
                                                                      })),
                                                                      initialIndex:
                                                                          index);
                                                              showImageViewerPager(
                                                                  context,
                                                                  backgroundColor: Colors
                                                                      .black
                                                                      .withAlpha(
                                                                          110),
                                                                  multiImageProvider,
                                                                  swipeDismissible:
                                                                      true,
                                                                  doubleTapZoomable:
                                                                      true,
                                                                  useSafeArea:
                                                                      true);
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: CachedNetworkImageProvider(
                                                                          mulimage))),
                                                            ),
                                                          );
                                                        },
                                                        mainAxisSpacing: 5.0,
                                                        crossAxisSpacing: 5.0,
                                                        staggeredTileBuilder:
                                                            (int index) {
                                                          return StaggeredTile
                                                              .count(
                                                                  multiphoto.length ==
                                                                          2
                                                                      ? 4
                                                                      : 2,
                                                                  2);
                                                        },
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                      options.isNotEmpty && options != []
                                          ? GetBuilder<ListOfPostsController>(
                                              initState: (_) {},
                                              builder: (_) {
                                                return SimplePollsWidget(
                                                  onSelection: (PollFrameModel
                                                          model,
                                                      PollOptions
                                                          selectedOptionModel) {
                                                    _.pollVoteUp(
                                                        postID:
                                                            postid.toString(),
                                                        voteID:
                                                            selectedOptionModel
                                                                .id
                                                                .toString());
                                                    // print('Now total polls are : ' +
                                                    //     model.totalPolls.toString());
                                                    // print('Selected option has label : ' +
                                                    //     selectedOptionModel.id);
                                                  },
                                                  onReset:
                                                      (PollFrameModel model) {
                                                    print(
                                                        'Poll has been reset, this happens only in case of editable polls');
                                                  },
                                                  optionsBorderShape:
                                                      const StadiumBorder(),
                                                  model: PollFrameModel(
                                                    title: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Linkify(
                                                        onOpen: (link) async {
                                                          if (!await launchUrl(
                                                              Uri.parse(
                                                                  link.url))) {
                                                            throw Exception(
                                                                'Could not launch ${link.url}');
                                                          }
                                                        },
                                                        text: postText,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    totalPolls: options[0]
                                                        ['all'],
                                                    endTime: DateTime.now()
                                                        .toUtc()
                                                        .add(const Duration(
                                                            days: 10)),
                                                    hasVoted: _.posts[index]
                                                            ['voted_id'] !=
                                                        null,
                                                    editablePoll: false,
                                                    options: List.generate(
                                                        options.length,
                                                        (j) => PollOptions(
                                                              label: options[j]
                                                                  ['text'],
                                                              pollsCount: int
                                                                  .parse(options[
                                                                          j][
                                                                      'option_votes']),
                                                              isSelected: _.posts[
                                                                          index]
                                                                      [
                                                                      'voted_id'] ==
                                                                  options[j]
                                                                      ['id'],
                                                              id: options[j]
                                                                  ['id'],
                                                            )),
                                                  ),
                                                );
                                              },
                                            )
                                          : const SizedBox(),
                                      _.posts[index]['postRecord'] != '' &&
                                              _.posts[index]['postRecord'] !=
                                                  null
                                          ? AudioPl(_, index)
                                          : const SizedBox(),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.black54, width: 1)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        //reshare
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  profileid !=
                                                          _.posts[index][
                                                                  'sharePostData']
                                                              ['user_id']
                                                      ? Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ViewProfileScreen(
                                                                    userviewid: _.posts[index]
                                                                            [
                                                                            'sharePostData']
                                                                        [
                                                                        'user_id'],
                                                                  )))
                                                      : null;
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  margin: const EdgeInsets.only(
                                                      left: 12, top: 12),
                                                  decoration:
                                                      Palette.RoundGradient,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          CachedNetworkImageProvider(_
                                                                          .posts[
                                                                      index][
                                                                  'sharePostData']
                                                              [
                                                              'publisher']['avatar']),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    GetBuilder<
                                                        ListOfPostsController>(
                                                      initState: (_) {},
                                                      builder: (_) {
                                                        var grpTitle = _
                                                            .categoryList
                                                            .firstWhereOrNull((element) =>
                                                                _.posts[index][
                                                                        'sharePostData']
                                                                    [
                                                                    'group_id'] ==
                                                                element[
                                                                    'group_id']);

                                                        return Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "${_.posts[index]['sharePostData']['publisher']['first_name']} ${_.posts[index]['sharePostData']['publisher']['last_name']}",
                                                              style: Palette
                                                                  .blacktext16,
                                                            ),
                                                            grpTitle != null
                                                                ? const Icon(
                                                                    Icons
                                                                        .arrow_right_rounded,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 30)
                                                                : const SizedBox(),
                                                            grpTitle != null
                                                                ? Flexible(
                                                                    child: Text(
                                                                      grpTitle[
                                                                          'group_title'],
                                                                      style: Palette
                                                                          .greytext12
                                                                          .copyWith(
                                                                              fontSize: 10),
                                                                    ),
                                                                  )
                                                                : const SizedBox(),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(
                                                          width: 3,
                                                        ),
                                                        const Icon(
                                                          Icons.access_time,
                                                          size: 13,
                                                          color: kGreyone,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            _.posts[index][
                                                                    'sharePostData']
                                                                ['post_time'],
                                                            style: Palette
                                                                .greytext12
                                                                .copyWith(
                                                                    fontSize:
                                                                        10),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20, top: 10),
                                              child: Text(
                                                _.posts[index]['sharePostData']
                                                    ['title'],
                                                style: Palette.blacktext14B
                                                    .copyWith(fontSize: 16),
                                              )),
                                          //reshare post
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _
                                                          .posts[index]
                                                              ['sharePostData']
                                                              ['options']
                                                          .isNotEmpty &&
                                                      _.posts[index][
                                                                  'sharePostData']
                                                              ['options'] !=
                                                          []
                                                  ? const SizedBox()
                                                  : rPostFeelingText != ''
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20,
                                                                  top: 6,
                                                                  bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              Linkify(
                                                                onOpen:
                                                                    (link) async {
                                                                  if (!await launchUrl(
                                                                      Uri.parse(
                                                                          link.url))) {
                                                                    throw Exception(
                                                                        'Could not launch ${link.url}');
                                                                  }
                                                                },
                                                                text: _.posts[
                                                                            index]
                                                                        [
                                                                        'sharePostData']
                                                                    [
                                                                    'Orginaltext'],
                                                              ),
                                                              const Text(" - "),
                                                              rfeelingType != 10
                                                                  ? Icon(
                                                                      feelingIcon[
                                                                          rfeelingType],
                                                                      size: 16,
                                                                    )
                                                                  : const SizedBox(),
                                                              Text(
                                                                  rPostFeelingText),
                                                            ],
                                                          ))
                                                      : (_.posts[index][
                                                                      'sharePostData']
                                                                  ['Orginaltext'] !=
                                                              '')
                                                          ? Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 20,
                                                                      top: 6,
                                                                      bottom:
                                                                          10),
                                                              child: Linkify(
                                                                onOpen:
                                                                    (link) async {
                                                                  if (!await launchUrl(
                                                                      Uri.parse(
                                                                          link.url))) {
                                                                    throw Exception(
                                                                        'Could not launch ${link.url}');
                                                                  }
                                                                },
                                                                text: _.posts[
                                                                            index]
                                                                        [
                                                                        'sharePostData']
                                                                    [
                                                                    'Orginaltext'],
                                                              ),
                                                              // Text(postText),here
                                                            )
                                                          : const SizedBox(
                                                              height: 6,
                                                            ),
                                              _.posts[index]['sharePostData']
                                                              ['postFile_full']
                                                          .contains(".jpeg") ||
                                                      _.posts[index]
                                                              ['sharePostData']
                                                              ['postFile_full']
                                                          .contains(".jpg") ||
                                                      _.posts[index]
                                                              ['sharePostData']
                                                              ['postFile_full']
                                                          .contains(".png")
                                                  ? GestureDetector(
                                                      onDoubleTap: () {
                                                        // setState(() {
                                                        //   _.islikeboollist[index] =
                                                        //       !_.islikeboollist[index];
                                                        //   if (_.islikeboollist[index] == true) {
                                                        //     setState(() {
                                                        //       _.posts[index]['reaction']['count']++;
                                                        //     });
                                                        //   } else {
                                                        //     setState(() {
                                                        //       _.posts[index]['reaction']['count']--;
                                                        //     });
                                                        //   }
                                                        LikedBloc(
                                                            postid,
                                                            "2",
                                                            _.posts[index]
                                                                    ['reaction']
                                                                ['is_reacted'],
                                                            widget.url);

                                                        // });
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            2,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .contain,
                                                                image: CachedNetworkImageProvider(
                                                                    _.posts[index]
                                                                            [
                                                                            'sharePostData']
                                                                        [
                                                                        'postFile_full']))),
                                                      ),
                                                    )
                                                  : _.posts[index]
                                                              ['sharePostData']
                                                              ['postFile_full']
                                                          .contains('.mp4')
                                                      ? GestureDetector(
                                                          onDoubleTap:
                                                              () async {
                                                            // setState(() {
                                                            //   _.islikeboollist[index] =
                                                            //       !_.islikeboollist[index];
                                                            //   if (_.islikeboollist[index] == true) {
                                                            //     setState(() {
                                                            //       _.posts[index]['reaction']
                                                            //           ['count']++;
                                                            //     });
                                                            //   } else {
                                                            //     setState(() {
                                                            //       _.posts[index]['reaction']
                                                            //           ['count']--;
                                                            //     });
                                                            //   }
                                                            LikedBloc(
                                                                postid,
                                                                "2",
                                                                _.posts[index][
                                                                            'sharePostData']
                                                                        [
                                                                        'reaction']
                                                                    [
                                                                    'is_reacted'],
                                                                widget.url);

                                                            // });
                                                          },
                                                          child: VideoPlayer(post: _.posts[index]['sharePostData']['postFile_full']))
                                                      // ? VideoPost(post: _post) hereitis
                                                      : rmultiImage == '1' && _.posts[index]['sharePostData']['postFile_full'] != " "
                                                          ? SizedBox(
                                                              height: 395,
                                                              child: StaggeredGridView
                                                                  .countBuilder(
                                                                // padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                                                crossAxisCount:
                                                                    4,
                                                                itemCount:
                                                                    rmultiphoto!
                                                                        .length,
                                                                primary: true,
                                                                //shrinkWrap: false,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  String
                                                                      mulimage =
                                                                      rmultiphoto[
                                                                              index]
                                                                          [
                                                                          'image'];
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      log("  multiphoto.length ${rmultiphoto.length}");
                                                                      log("multiphoto[index]['image'] ${rmultiphoto[index]['image']}");
                                                                      MultiImageProvider
                                                                          multiImageProvider =
                                                                          MultiImageProvider(
                                                                              List.generate(rmultiphoto.length, ((index) {
                                                                                return Image(
                                                                                    image: CachedNetworkImageProvider(
                                                                                  rmultiphoto[index]['image'],
                                                                                )).image;
                                                                              })),
                                                                              initialIndex: index);
                                                                      showImageViewerPager(
                                                                          context,
                                                                          backgroundColor: Colors.black.withAlpha(
                                                                              110),
                                                                          multiImageProvider,
                                                                          swipeDismissible:
                                                                              true,
                                                                          doubleTapZoomable:
                                                                              true,
                                                                          useSafeArea:
                                                                              true);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          image: DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: CachedNetworkImageProvider(mulimage))),
                                                                    ),
                                                                  );
                                                                },
                                                                mainAxisSpacing:
                                                                    5.0,
                                                                crossAxisSpacing:
                                                                    5.0,
                                                                staggeredTileBuilder:
                                                                    (int
                                                                        index) {
                                                                  return StaggeredTile.count(
                                                                      rmultiphoto.length ==
                                                                              2
                                                                          ? 4
                                                                          : 2,
                                                                      2);
                                                                },
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                              _
                                                          .posts[index]
                                                              ['sharePostData']
                                                              ['options']
                                                          .isNotEmpty &&
                                                      _.posts[index][
                                                                  'sharePostData']
                                                              ['options'] !=
                                                          []
                                                  ? GetBuilder<
                                                      ListOfPostsController>(
                                                      initState: (_) {},
                                                      builder: (_) {
                                                        return SimplePollsWidget(
                                                          onSelection:
                                                              (PollFrameModel
                                                                      model,
                                                                  PollOptions
                                                                      selectedOptionModel) {
                                                            _.pollVoteUp(
                                                                postID: _.posts[
                                                                        index][
                                                                        'sharePostData']
                                                                        [
                                                                        'post_id']
                                                                    .toString(),
                                                                voteID: selectedOptionModel
                                                                    .id
                                                                    .toString());
                                                            // print('Now total polls are : ' +
                                                            //     model.totalPolls.toString());
                                                            // print('Selected option has label : ' +
                                                            //     selectedOptionModel.id);
                                                          },
                                                          onReset:
                                                              (PollFrameModel
                                                                  model) {
                                                            print(
                                                                'Poll has been reset, this happens only in case of editable polls');
                                                          },
                                                          optionsBorderShape:
                                                              const StadiumBorder(),
                                                          model: PollFrameModel(
                                                            title: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Linkify(
                                                                onOpen:
                                                                    (link) async {
                                                                  if (!await launchUrl(
                                                                      Uri.parse(
                                                                          link.url))) {
                                                                    throw Exception(
                                                                        'Could not launch ${link.url}');
                                                                  }
                                                                },
                                                                text: _.posts[
                                                                        index][
                                                                        'sharePostData']
                                                                        [
                                                                        'Orginaltext']
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            totalPolls: _.posts[
                                                                        index][
                                                                    'sharePostData']
                                                                [
                                                                'options'][0]['all'],
                                                            endTime: DateTime
                                                                    .now()
                                                                .toUtc()
                                                                .add(const Duration(
                                                                    days: 10)),
                                                            hasVoted: _.posts[
                                                                            index]
                                                                        [
                                                                        'sharePostData']
                                                                    [
                                                                    'voted_id'] !=
                                                                null,
                                                            editablePoll: false,
                                                            options:
                                                                List.generate(
                                                                    _
                                                                        .posts[
                                                                            index]
                                                                            [
                                                                            'sharePostData']
                                                                            [
                                                                            'options']
                                                                        .length,
                                                                    (j) =>
                                                                        PollOptions(
                                                                          label:
                                                                              _.posts[index]['sharePostData']['options'][j]['text'],
                                                                          pollsCount:
                                                                              int.parse(_.posts[index]['sharePostData']['options'][j]['option_votes']),
                                                                          isSelected:
                                                                              _.posts[index]['sharePostData']['voted_id'] == _.posts[index]['sharePostData']['options'][j]['id'],
                                                                          id: _.posts[index]['sharePostData']['options'][j]
                                                                              [
                                                                              'id'],
                                                                        )),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : const SizedBox(),
                                              _.posts[index]['sharePostData']
                                                              ['postRecord'] !=
                                                          '' &&
                                                      _.posts[index][
                                                                  'sharePostData']
                                                              ['postRecord'] !=
                                                          null
                                                  ? AudioPl(_, index)
                                                  : const SizedBox(),
                                              const SizedBox(
                                                height: 12,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            _.isReacting[index]
                                ? Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    elevation: 10,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                          _.reactionsURL.length,
                                          (subIndex) => InkWell(
                                            onTap: () {
                                              // _.selectedReaction[index] = subIndex;
                                              _.isReacting[index] = false;

                                              log(subIndex.toString());
                                              LikedBloc(
                                                  postid,
                                                  _.reactionsURL[subIndex].id,
                                                  false,
                                                  widget.url);
                                              // _.update();
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  _.reactionsURL[subIndex].url,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            SizedBox(
                                height:
                                    multiImage == '1' && post != " " ? 25 : 10),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                          radius: 20,
                                          backgroundColor: kThemeColorLightGrey
                                              .withOpacity(0.4),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _.islikeboollist[index] =
                                                    !_.islikeboollist[index];
                                                if (_.islikeboollist[index] ==
                                                    true) {
                                                  setState(() {
                                                    _.posts[index]['reaction']
                                                        ['count']++;
                                                    _.posts[index]['reaction']
                                                        ['type'] = '2';
                                                  });
                                                } else {
                                                  setState(() {
                                                    _.posts[index]['reaction']
                                                        ['count']--;
                                                    _.posts[index]['reaction']
                                                        ['type'] = '';
                                                  });
                                                }
                                                LikedBloc(
                                                    postid,
                                                    "2",
                                                    _.posts[index]['reaction']
                                                        ['is_reacted'],
                                                    widget.url);
                                              });
                                            },
                                            onLongPress: () {
                                              _.isReacting[index] = true;
                                              _.update();
                                            },
                                            child: _.posts[index]['reaction']
                                                        ['type'] !=
                                                    ""
                                                ? SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: CachedNetworkImage(
                                                      imageUrl: _
                                                          .reactionsURL[_
                                                              .reactionsURL
                                                              .indexWhere((element) =>
                                                                  element.id.contains(
                                                                      _.posts[index]
                                                                              [
                                                                              'reaction']
                                                                          [
                                                                          'type']))]
                                                          .url,
                                                      progressIndicatorBuilder: (context,
                                                              url,
                                                              downloadProgress) =>
                                                          const CupertinoActivityIndicator
                                                              .partiallyRevealed(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  )
                                                // : _.islikeboollist[index]
                                                //     ? const Icon(
                                                //         Icons.favorite,
                                                //         color: kred,
                                                //       )
                                                : Icon(
                                                    Icons
                                                        .favorite_outline_sharp,
                                                    color: Colors.black87
                                                        .withOpacity(0.6),
                                                  ),
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${_.posts[index]['reaction']['count']}',
                                        style: Palette.greytext12,
                                      )
                                    ],
                                  ),
                                  Visibility(
                                    visible: iscommentstatus,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          children: [
                                            GetBuilder<ListOfPostsController>(
                                              initState: (_) {},
                                              builder: (_) {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CommentScreen(
                                                                  commentdata:
                                                                      commentdata,
                                                                )));

                                                    //         .then(
                                                    // (value) => (value) {

                                                    //       setState(() {
                                                    //         _.fetchallpost(_.pageno);
                                                    //         _.update();
                                                    //         print(_.posts[index]
                                                    //             ['post_comments']);
                                                    //       });
                                                    //   });
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        kThemeColorLightGrey
                                                            .withOpacity(0.4),
                                                    child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/comment.png'))),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              comment,
                                              style: Palette.greytext12,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      _.posts[index]['sharePostData'] == null
                                          ? InkWell(
                                              onTap: () {
                                                //reshare dialogue

                                                reshareDialogue(
                                                  context,
                                                  _.posts[index]['post_url']
                                                      .toString(),
                                                  _.posts[index]['title']
                                                      .toString(),
                                                  _.posts[index]['post_id']
                                                      .toString(),
                                                  _.posts[index]['type_id']
                                                      .toString(),
                                                );
                                                // sharePostDialogue(shareUrl);
                                              },
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    kThemeColorLightGrey
                                                        .withOpacity(0.4),
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/postshareicon.png'))),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '',
                                        style: Palette.greytext12,
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  pinpoststatus == true
                                      ? Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Icon(
                                              Icons.push_pin,
                                              color: Colors.cyanAccent,
                                              size: 28,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '',
                                              style: Palette.greytext12,
                                            )
                                          ],
                                        )
                                      : const SizedBox(),
                                  Column(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _.issavepostboollist[index] =
                                                  !_.issavepostboollist[index];
                                              SavepostBloc(postid,
                                                  _keyLoadersavepost, context);
                                              // _.fetchallpost(
                                              //     _.pageno, widget.url);
                                            });
                                          },
                                          child: _.issavepostboollist[index]
                                              ? const Icon(
                                                  Icons.bookmark,
                                                  color: Colors.blueAccent,
                                                  size: 28,
                                                )
                                              : const Icon(
                                                  Icons.bookmark_outline_sharp,
                                                  color: kGreyone,
                                                  size: 28,
                                                )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '',
                                        style: Palette.greytext12,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget AudioPl(ListOfPostsController _, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black26, borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  _.aud[index].isPlaying = !_.aud[index].isPlaying;
                  if (_.aud[index].firstTime) {
                    _.aud[index].duration = await _.aud[index].player
                        .setAudioSource(AudioSource.uri(Uri.parse(
                            'http://bettersolver.com/demo2/${_.posts[index]['postRecord']}')));

                    _.aud[index].firstTime = false;
                  }

                  await _.aud[index].player.setVolume(1);

                  _.aud[index].isPlaying
                      ? await _.aud[index].player.play()
                      : await _.aud[index].player.pause();
                  _.update();
                },
                child: StreamBuilder<bool>(
                    stream: _.aud[index].player.playingStream,
                    builder: (context, snapshot) {
                      return Icon(
                        snapshot.data ?? false
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        size: 30,
                      );
                    }),
              ),
              Expanded(
                child: StreamBuilder<Duration>(
                    stream: _.aud[index].player.positionStream,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        if ((_.aud[index].duration != null
                                ? _.aud[index].duration!.inMilliseconds
                                    .toDouble()
                                : 1) ==
                            snapshot.data!.inMilliseconds.toDouble()) {
                          log("finished");
                          _.aud[index].firstTime = true;
                          _.aud[index].player.stop();
                        }
                      }

                      return Slider(
                        min: 0,
                        max: _.aud[index].duration != null
                            ? _.aud[index].duration!.inMilliseconds.toDouble()
                            : 0,
                        value: snapshot.data == null
                            ? 0
                            : (_.aud[index].duration != null
                                        ? _.aud[index].duration!.inMilliseconds
                                            .toDouble()
                                        : 0) <=
                                    snapshot.data!.inMilliseconds.toDouble()
                                ? 0
                                : snapshot.data!.inMilliseconds.toDouble(),
                        activeColor: Colors.black,
                        inactiveColor: Colors.black54,
                        allowedInteraction: SliderInteraction.tapOnly,
                        onChanged: (value) {
                          log(value.toString());

                          // log('${value.toString()}--->${_.aud[index].duration!.inMilliseconds.toString()}');
                        },
                      );
                    }),
              ),
              InkWell(
                  onTap: () async {
                    _.aud[index].curVolume = !_.aud[index].curVolume;
                    await _.aud[index].player
                        .setVolume(_.aud[index].curVolume ? 1 : 0);
                    _.update();
                  },
                  child: Icon(_.aud[index].curVolume
                      ? Icons.volume_up_rounded
                      : Icons.volume_off_rounded)),
              const SizedBox(
                width: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> edit_post_dialogue(
      String postId, String title1, String title2, String catId) async {
    CreatePostController _ = Get.put(CreatePostController());

    _.titleController.text = title1;
    _.captionController.text = title2;

    // print(titleController + " " + captionController + " " + categoryType);
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: GetBuilder<CreatePostController>(
            initState: (_) {},
            builder: (_) {
              print(_.categoryList);
              return SimpleDialog(
                backgroundColor: kWhite,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      const SizedBox(height: 10.0),
                      Text(
                        'Edit Post',
                        style: Palette.appbarTitle,
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                                colors: [kThemeColorBlue, kThemeColorGreen])),
                        child: Padding(
                          padding: const EdgeInsets.all(0.8),
                          child: TextField(
                            controller: _.titleController,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400, fontSize: 12),
                            decoration: InputDecoration(
                              fillColor: kWhite,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: const EdgeInsets.all(8.0),
                              hintText: 'Title',
                              labelStyle:
                                  GoogleFonts.roboto(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                                colors: [kThemeColorBlue, kThemeColorGreen])),
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          // icon: Icon(Icons.add_location),
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                          ),
                          value: _.categoryType,
                          hint: Text(
                            'Select Category',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: kBlack),
                          ),
                          items: _.categoryList.map((item) {
                            return DropdownMenuItem(
                              value: item['id'],
                              child: Text(
                                item['name'],
                                style: Palette.black_title,
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            fillColor: kWhite,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: const EdgeInsets.all(8.0),
                            hintText: 'type somthing....',
                            labelStyle: GoogleFonts.roboto(color: Colors.grey),
                          ),
                          onChanged: (newValue) {
                            _.categoryType = newValue;
                          },
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                                colors: [kThemeColorBlue, kThemeColorGreen])),
                        child: Padding(
                          padding: const EdgeInsets.all(0.8),
                          child: TextField(
                            controller: _.captionController,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400, fontSize: 12),
                            decoration: InputDecoration(
                              fillColor: kWhite,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: const EdgeInsets.all(8.0),
                              hintText: 'type somthing....',
                              labelStyle:
                                  GoogleFonts.roboto(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: kThemeColorBlue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: () {
                                    reportTextController.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: Palette.splashscreenskip,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: kThemeColorLightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                onTap: () {
                                  EasyLoading.show();
                                  // print("Edit Post $_.categoryType");
                                  //LoadingDialog.showLoadingDialog(context, _keyLoader);
                                  EditPostBloc(
                                      postId,
                                      _.captionController.text,
                                      _.categoryType,
                                      _.titleController.text,
                                      _keyLoader,
                                      context);
                                  // Navigator.pop(context);
                                },
                                child: Center(
                                  child: Text(
                                    'Update',
                                    style: Palette.splashscreenskip,
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget ReturnOfFooter(Widget body) {
    return SizedBox(
      height: 55.0,
      child: Center(child: body),
    );
  }

  Widget _popupmenuforour(String postid, bool type, bool pintype, int index,
      String postTitle, String postText, String groupid) {
    String typevalue = '0';
    if (type == true) {
      typevalue = '0';
    } else {
      typevalue = '1';
    }
    //print('/*-++-*//*-+');
    ListOfPostsController _ = Get.find();
    return PopupMenuButton(
        shape: Palette.cardShape,
        offset: const Offset(100, 0),
        elevation: 8.0,
        //  enabled: true,
        child: Container(
          margin: const EdgeInsets.only(right: 10, top: 10),
          child: const Icon(Icons.more_horiz),
        ),
        itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Value1',
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    edit_post_dialogue(postid, postTitle, postText, groupid);
                  },
                  child: const Row(
                    children: <Widget>[
                      Icon(Icons.edit, color: Colors.yellow),
                      SizedBox(width: 10),
                      Text('Edit Post'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'Value2',
                child: InkWell(
                  child: const Row(
                    children: <Widget>[
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 10),
                      Text('Delete Post'),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      showAlertDialogDeletePost(context, postid, index);
                    });
                  },
                ),
              ),
              PopupMenuItem(
                value: 'Value3',
                child: GetBuilder<ListOfPostsController>(
                  initState: (_) {},
                  builder: (_) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          // print('typle ');
                          //print('postid ');
                          Navigator.pop(context);
                          EnableDisableCommentBloc(
                              postid, typevalue, _keyLoadercomment, context);

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HomeScreen()));
                          // _allpostBloc!.allpostblocDataSink;
                          _.fetchallpost(_.pageno, widget.url);
                          // setState(() {
                          //   _.posts[index]['comments_status'] == "1"
                          //       ? _.posts[index]['comments_status'] = "0"
                          //       : _.posts[index]['comments_status'] = "1";
                          //   // _allpostBloc =
                          //   //     AllpostBloc(_pageno.toString(), firstLoad);
                          // });

                          // _userTimeLineBloc = UserTimeLineBloc(pageno, _keyLoader, context);
                          // ispage = false;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          typevalue == '0'
                              ? const Icon(Icons.speaker_notes_off_outlined,
                                  color: Colors.blue)
                              : const Icon(Icons.comment_outlined,
                                  color: Colors.blue),
                          const SizedBox(width: 10),
                          typevalue == '0'
                              ? const Text('Disable Comment')
                              : const Text('Enable Comment')
                        ],
                      ),
                    );
                  },
                ),
              ),
              // PopupMenuItem(
              //   value: 'Value4',
              //   child: InkWell(
              //     onTap: () {
              //       setState(() {
              //         Navigator.pop(context);
              //         // PinPostBloc(postid, _keyLoaderpin, context);

              //         // _allpostBloc = AllpostBloc(pageno, _keyLoader, context);
              //       });
              //     },
              //     child: Row(
              //       children: <Widget>[
              //         const Icon(Icons.push_pin, color: Colors.cyanAccent),
              //         const SizedBox(width: 10),
              //         pintype == true
              //             ?Text('Unpin post')
              //             :Text('Pin Post'),
              //       ],
              //     ),
              //   ),
              // ),
            ]);
  }

  Widget _popupmenuForOther(String postid, int index) {
    return PopupMenuButton(
        shape: Palette.cardShape,
        offset: const Offset(100, 0),
        elevation: 8.0,
        child: Container(
          margin: const EdgeInsets.only(right: 10, top: 10),
          child: const Icon(Icons.more_horiz),
        ),
        itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Value1',
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    showAlertDialogForReport(
                        context: context, postid: postid, index: index);
                  },
                  child: const Row(
                    children: <Widget>[
                      Icon(Icons.flag_outlined, color: Colors.yellow),
                      SizedBox(width: 10),
                      Text('Report Post'),
                    ],
                  ),
                ),
              ),
              // PopupMenuItem(
              //   value: 'Value2',
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.pop(context);
              //       showAlertDialogForHide(
              //           context: context, postid: postid, index: index);
              //     },
              //     child: Row(
              //       children: const <Widget>[
              //         Icon(Icons.remove_red_eye, color: Colors.red),
              //         SizedBox(width: 10),
              //         Text('Hide Post'),
              //       ],
              //     ),
              //   ),
              // ),
            ]);
  }

  showAlertDialogForReport(
      {required BuildContext context,
      required String postid,
      required int index}) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      child: Text(
        "Cancel",
        style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = MaterialButton(
      child: Text(
        "Yes",
        style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.pop(context);
        reportpostDialogue(context, postid, index);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title:Text("Logout"),
      content: const Text("Are you sure to report this post?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> reportpostDialogue(
      BuildContext context, String postid, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            backgroundColor: kWhite,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'Report Post',
                      style: Palette.appbarTitle,
                    ),
                  ),
                  // Container(
                  //   height: 40,
                  //   margin: const EdgeInsets.fromLTRB(35, 15, 35, 10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       gradient: const LinearGradient(
                  //           colors: [kThemeColorBlue, kThemeColorGreen])),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(0.8),
                  //     child: TextField(
                  //       controller: reportTextController,
                  //       keyboardType: TextInputType.emailAddress,
                  //       style: GoogleFonts.roboto(
                  //           fontWeight: FontWeight.w400, fontSize: 12),
                  //       decoration: InputDecoration(
                  //         fillColor: kWhite,
                  //         filled: true,
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide: const BorderSide(
                  //               color: Colors.transparent, width: 1.0),
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide: const BorderSide(
                  //               color: Colors.transparent, width: 1.0),
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         border: OutlineInputBorder(
                  //           borderSide: const BorderSide(
                  //               color: Colors.transparent, width: 1.0),
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         disabledBorder: OutlineInputBorder(
                  //           borderSide: const BorderSide(
                  //               color: Colors.transparent, width: 1.0),
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         contentPadding: const EdgeInsets.all(8.0),
                  //         hintText: 'type somthing....',
                  //         labelStyle: GoogleFonts.roboto(color: Colors.grey),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: kThemeColorLightBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              ReportPostBloc(postid, 'It\'s Spam',
                                  _keyLoaderreport, context);
                              _.posts.remove(_.posts[index]);
                              _.update();
                              reportTextController.clear();
                              print("reported");
                              Navigator.pop(context);
                            },
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('It\'s Spam'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: kThemeColorLightBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              ReportPostBloc(postid, 'It\'s inappropriate',
                                  _keyLoaderreport, context);
                              _.posts.remove(_.posts[index]);
                              _.update();
                              reportTextController.clear();
                              print("reported");
                              Navigator.pop(context);
                            },
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('It\'s Inappropriate'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: kThemeColorBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              reportTextController.clear();
                              Navigator.pop(context);
                            },
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Cancel'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       height: 40,
                  //       width: 80,
                  //       decoration: BoxDecoration(
                  //           color: kThemeColorBlue,
                  //           borderRadius: BorderRadius.circular(10)),
                  //       child: InkWell(
                  //         onTap: () {
                  //           reportTextController.clear();
                  //           Navigator.pop(context);
                  //         },
                  //         child: const Center(
                  //           child: Text('Cancel'),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 30,
                  //     ),
                  //     Container(
                  //       height: 40,
                  //       width: 80,
                  //       decoration: BoxDecoration(
                  //           color: kThemeColorLightBlue,
                  //           borderRadius: BorderRadius.circular(10)),
                  //       child: GetBuilder<ListOfPostsController>(
                  //         initState: (_) {},
                  //         builder: (_) {
                  //           return InkWell(
                  //             onTap: () {
                  //               //print('Post id ----');
                  //               //print('Post id ----${reportTextController.text}');
                  //               if (reportTextController.text.isEmpty) {
                  //                 ErrorDialouge.showErrorDialogue(context,
                  //                     _keyError, "Please write something");
                  //               } else {
                  //                 ReportPostBloc(
                  //                     postid,
                  //                     reportTextController.text,
                  //                     _keyLoaderreport,
                  //                     context);
                  //                 // _.fetchallpost(_.pageno);
                  //                 _.posts.remove(_.posts[index]);
                  //                 _.update();
                  //                 reportTextController.clear();
                  //                 print("reported");
                  //                 Navigator.pop(context);
                  //               }
                  //             },
                  //             child: const Center(
                  //               child: Text('Report'),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     )
                  //   ],
                  // ),

                  ,
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> reshareDialogue(BuildContext context, String post,
      String content, String postId, String typeId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            backgroundColor: kWhite,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'Share Post',
                      style: Palette.appbarTitle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: kThemeColorLightBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () async {
                              //timeline
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              String? s = pref.getString('s');
                              String? userid = pref.getString('userid');
                              final requestBody = {
                                "user_id": userid,
                                "s": s,
                                'post_id': postId,
                                'type_id': typeId,
                                'share_on': 'timeline',
                                'text': '',
                              };

                              final response =
                                  await ApiProvider().httpMethodWithoutToken(
                                'post',
                                'demo2/app_api.php?application=phone&type=share_post',
                                requestBody,
                              );
                              var data = AllPostModel.fromJson(response);
                              if (data.apiStatus == "200") {
                                Navigator.pop(context);
                                _.onRefresh();
                              }
                            },
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Share to My Timeline'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: kThemeColorLightBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Share.share(
                                  'check out this post on Better Solver $post',
                                  subject: content);
                            },
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Share to Others'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: kThemeColorBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Cancel'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  showAlertDialogForHide(
      {required BuildContext context,
      required String postid,
      required int index}) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      child: Text(
        "Cancel",
        style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = GetBuilder<ListOfPostsController>(
      initState: (_) {},
      builder: (_) {
        return MaterialButton(
          child: Text(
            "Yes",
            style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
          ),
          onPressed: () async {
            setState(() {
              _.posts.remove(_.posts[index]);
              Navigator.pop(context);
              LoadingDialog.showLoadingDialog(context, _keyLoader);
              HidePostBloc(postid, _keyLoader, context);
              _.onRefresh();
            });
          },
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title:Text("Logout"),
      content: const Text("Are you sure to Hide this post?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogDeletePost(BuildContext context, String postid, int index) {
    ListOfPostsController _ = Get.find();

    Widget cancelButton = MaterialButton(
      child: Text(
        "Cancel",
        style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = GetBuilder<ListOfPostsController>(
      initState: (_) {},
      builder: (_) {
        return MaterialButton(
          child: Text(
            "Yes",
            style: GoogleFonts.roboto(fontSize: 14.0, color: Colors.black),
          ),
          onPressed: () {
            // Navigator.pop(context);
            LoadingDialog.showLoadingDialog(context, _keyLoader);
            DeletePostBloc(postid, _keyLoader, context, onSuccess: () {
              setState(() {
                print("deleted");
                _.posts.remove(index);
                _.fetchallpost(_.pageno, widget.url);
              });
            });
            // setState(() {
            //   posts.remove(index);
            // });
          },
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title:Text("Logout"),
      content: const Text("Are you sure to delete this post?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void logoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }
}

class ReactionType {
  String id;
  String url;
  ReactionType({required this.id, required this.url});
}

class AudioCl {
  bool isPlaying;
  Duration? duration;
  bool curVolume;
  int currPosition;
  AudioPlayer player;
  bool firstTime;

  AudioCl(
      {this.curVolume = true,
      this.currPosition = 0,
      this.duration,
      required this.player,
      this.firstTime = true,
      this.isPlaying = false});
}
