import 'dart:async';
import 'dart:developer';

import 'package:bettersolver/screen/msg_group_chat/chatController.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  String image;
  String name;
  String lastSeen;
  String userID;

  ChatScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.lastSeen,
      required this.userID});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Timer _timer;
  @override
  void dispose() {
    _timer.cancel();
    log("disposed");
    msgcontroller.clear();
    _.messages.clear();
    super.dispose();
  }

  final ChatController _ = Get.put(ChatController());
  TextEditingController msgcontroller = TextEditingController();
  ScrollController sc = ScrollController();
  @override
  void initState() {
    _.fetchMEssage(widget.userID);
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      _.fetchMEssage(widget.userID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      initState: (_) {},
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            Get.back();
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 100,
                  decoration: Palette.loginGradient,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    decoration: const BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25))),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 25,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              CachedNetworkImageProvider(widget.image),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: Palette.blacktext20M,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '◉ ${widget.lastSeen}',
                                style: Palette.greytext14,
                              )
                            ],
                          ),
                        ),
                        // Container(
                        //   height: 40,
                        //   width: 40,
                        //   margin: const EdgeInsets.only(right: 15),
                        //   decoration: const BoxDecoration(
                        //       image: DecorationImage(
                        //           image: AssetImage(
                        //               'assets/images/doticon.png'))),
                        // )
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 0, left: 10, right: 10),
                    child: ListView.separated(
                      controller: sc,
                      addAutomaticKeepAlives: true,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _.messages.isEmpty ? 0 : _.messages.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemBuilder: (context, index) {
                        // MediaQuery.of(context).viewInsets.bottom == 0
                        //     ? sc.animateTo(sc.position.maxScrollExtent,
                        //         duration: Duration(milliseconds: 500),
                        //         curve: Curves.fastOutSlowIn)
                        //     : null;
                        return _.messages[index]['position'] == 'right'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Spacer(),
                                  Flexible(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                              // bottomRight: Radius.circular(20),
                                              topRight: Radius.circular(12),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            child: Text(
                                                _.messages[index]['text'],
                                                softWrap: true,
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 1,
                                        ),
                                        (_.messages.length - 1 == index &&
                                                _.messages[index]['seen'] !=
                                                    '0')
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .remove_red_eye_rounded,
                                                    size: 10,
                                                  ),
                                                  Text(
                                                      " ${formatTimeDifference(_.messages[index]['seen'])}",
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 10,
                                                          color: Colors.black)),
                                                ],
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundImage: CachedNetworkImageProvider(
                                        widget.image),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          // bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Text(_.messages[index]['text'],
                                            style: GoogleFonts.roboto(
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Card(
                    margin: const EdgeInsets.all(0),
                    elevation: 0.0,
                    color: kWhite,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5, top: 5),
                              child: TextField(
                                onTap: () {
                                  log('ontap');
                                  sc.jumpTo(0);
                                  sc.animateTo(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      sc.position.maxScrollExtent + 1000,
                                      curve: Curves.linear);
                                  // Timer(
                                  //     const Duration(milliseconds: 300),
                                  //     () => sc.jumpTo(
                                  //         sc.position.maxScrollExtent));
                                },
                                controller: msgcontroller,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Write Message…",
                                  filled: true,
                                  fillColor: kThemeColorLightGrey,
                                  hintStyle: Palette.greytext12,
                                  // labelText: "Email",
                                  contentPadding: const EdgeInsets.all(5),
                                  labelStyle: GoogleFonts.roboto(
                                      color: const Color(0xFF424242)),
                                  // fillColor: kBlack,
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
                          InkWell(
                            onTap: () {
                              msgcontroller.text == ''
                                  ? null
                                  : _
                                      .sendMessage(
                                          ID: widget.userID,
                                          text: msgcontroller.text)
                                      .then(msgcontroller.clear());
                              sc.animateTo(
                                  duration: const Duration(milliseconds: 300),
                                  sc.position.maxScrollExtent,
                                  curve: Curves.linear);
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
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      },
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
