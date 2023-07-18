import 'package:bettersolver/bloc/user_timeline_bloc.dart';
import 'package:bettersolver/models/user_timeline_model.dart';
import 'package:bettersolver/screen/ListofPosts.dart';

import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeLineScreen extends StatefulWidget {
  String? userid;

  TimeLineScreen({super.key, this.userid});

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  UserTimeLineBloc? _userTimeLineBloc;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyLoadercomment = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderlike = GlobalKey<State>();
  final GlobalKey<State> _keyLoadersavepost = GlobalKey<State>();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<State> _keyError = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderreport = GlobalKey<State>();
  TextEditingController reportTextController = TextEditingController();

  bool ispage = true;

  int pageno = 1;

  bool firstLoad = true;
  bool isLoading = false;
  List posts = [];

  bool liked = false;
  List islikeboollist = [];

  bool savepost = false;
  List issavepostboollist = [];

  String? profileid;

  @override
  void initState() {
    shared();
    _userTimeLineBloc = UserTimeLineBloc(
        pageno.toString(), widget.userid!, _keyLoader, context);

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          print('list scroll at top');
        } else {
          print('list scroll at bottom');
          ispage = true;

          try {
            firstLoad = false;
            isLoading = true;
            _userTimeLineBloc!.fetchusertimelineData(
                pageno.toString(), widget.userid!, _keyLoader, context);
          } catch (e) {
            debugPrint('Error: $e');
          }
        }
      }
    });
    super.initState();
  }

  shared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    profileid = pref.getString('userid');
    print('132456798-$profileid');
    setState(() {});
  }

  /// in comment that comment number show 1 but in comment list is empty -- backend side problem

  /// video is not working beasue problem in url

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhite,
        title: Text(
          'TIMELINE',
          style: Palette.greytext20B,
        ),
      ),
      body: Stack(
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
              margin: const EdgeInsets.only(top: 30),
              child: StreamBuilder(
                  stream: _userTimeLineBloc!.usertimelineBlocDataStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(loadingMessage: snapshot.data.message);
                        case Status.COMPLETED:
                          return _pagenation(snapshot.data.data);
                        case Status.ERROR:
                          return const Text(
                            'Errror msg',
                          );
                      }
                    }
                    return Container();
                  }))
        ],
      ),
    );
  }

  Widget _pagenation(UserTimeLineModel userTimeLineModel) {
    posts.addAll(userTimeLineModel.posts);
    RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListOfPosts(
          posts: userTimeLineModel.posts,
          url: 'demo2/app_api.php?application=phone&type=get_user_posts',
          refreshController: refreshController,
        ),
      ],
    );
  }
}
