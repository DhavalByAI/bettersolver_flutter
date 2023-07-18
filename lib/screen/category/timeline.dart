import 'package:bettersolver/screen/ListofPosts.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostsOfCategory extends StatelessWidget {
  List posts;
  String title;
  PostsOfCategory({super.key, required this.posts, required this.title});

  @override
  Widget build(BuildContext context) {
    RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          backgroundColor: kWhite,
          elevation: 0,
        ),
        body: Container(
          child: Column(
            children: [
              ListOfPosts(
                posts: posts,
                url: "",
                refreshController: refreshController,
              )
            ],
          ),
        ));
  }
}
