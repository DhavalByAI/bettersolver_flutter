import 'package:bettersolver/bottom_navigation.dart';
import 'package:bettersolver/screen/ListofPosts.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'postView_controller.dart';

class PostView extends StatefulWidget {
  String postId;
  PostView({super.key, required this.postId});
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final PostViewController _ = Get.put(PostViewController());

  String? profileid;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    _.fetchAPI(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
        return true;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          centerTitle: true,
          backgroundColor: kWhite,
          title: Text(
            'POST',
            style: Palette.greytext20B,
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: 20,
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
            GetBuilder<PostViewController>(
              initState: (_) {},
              builder: (_) {
                return _.posts != []
                    ? Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: tempList(_.posts))
                    : const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget tempList(List posts) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListOfPosts(
          refreshController: refreshController,
          posts: posts,
          url: "demo2/app_api.php?application=phone&type=get_post_data",
        ),
      ],
    );
  }
}
