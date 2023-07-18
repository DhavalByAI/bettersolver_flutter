import 'package:bettersolver/bloc/save_post_list_bloc.dart';
import 'package:bettersolver/models/save_post_list_model.dart';
import 'package:bettersolver/screen/ListofPosts.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavePostListScreen extends StatefulWidget {
  const SavePostListScreen({super.key});

  @override
  State<SavePostListScreen> createState() => _SavePostListScreenState();
}

class _SavePostListScreenState extends State<SavePostListScreen> {
  SavePostListBloc? _savePostListBloc;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyLoadersavepost = GlobalKey<State>();
  final GlobalKey<State> _keyLoadercomment = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderreport = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderhide = GlobalKey<State>();
  final GlobalKey<State> _keyError = GlobalKey<State>();

  TextEditingController reportTextController = TextEditingController();
  List posts = [];

  bool liked = false;
  List islikeboollist = [];

  bool savepost = false;
  List issavepostboollist = [];

  String? profileid;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    _savePostListBloc = SavePostListBloc(_keyLoader, context);
    shared();
  }

  shared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    profileid = pref.getString('userid');
  }

  /// Hide post problem api side
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhite,
        title: Text(
          'SAVED',
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
          Container(
              margin: const EdgeInsets.only(top: 30),
              child: StreamBuilder(
                  stream: _savePostListBloc!.savepostlistBlocDataStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(loadingMessage: snapshot.data.message);
                        case Status.COMPLETED:
                          return tempList(snapshot.data.data);
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

  Widget tempList(SavePostListModel savePostListModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListOfPosts(
          refreshController: refreshController,
          posts: savePostListModel.posts,
          url: "demo2/app_api.php?application=phone&type=get_saved_posts",
        ),
      ],
    );
  }

  bool pinpoststatus = false;
  List ispinpostList = [];
  final GlobalKey<State> _keyLoaderpin = GlobalKey<State>();
}
