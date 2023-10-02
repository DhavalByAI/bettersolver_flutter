import 'package:bettersolver/bloc/category_details_bloc.dart';
import 'package:bettersolver/models/category_details_model.dart';
import 'package:bettersolver/screen/ListofPosts.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Photo extends StatefulWidget {
  String? groupid;

  Photo({super.key, this.groupid});

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  CategoryDetailsBloc? _categoryDetailsBloc;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderlike = GlobalKey<State>();
  final GlobalKey<State> _keyLoadersavepost = GlobalKey<State>();
  final GlobalKey<State> _keyLoadercomment = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderreport = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderhide = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderpin = GlobalKey<State>();

  final GlobalKey<State> _keyError = GlobalKey<State>();

  TextEditingController reportTextController = TextEditingController();

  var alldata;
  List allphotos = [];

  bool liked = false;
  List islikeboollist = [];

  bool savepost = false;
  List issavepostboollist = [];

  String? profileid;

  bool pinpoststatus = false;
  List ispinpostList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryDetailsBloc =
        CategoryDetailsBloc(widget.groupid!, _keyLoader, context);
    shared();
  }

  shared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    profileid = pref.getString('userid');
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          title: const Text('Photos'),
          centerTitle: true,
          backgroundColor: kWhite,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: _categoryDetailsBloc!.categorydetailsblocDataStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);
                  case Status.COMPLETED:
                    return _listpost(snapshot.data.data);

                  case Status.ERROR:
                    return const Text(
                      'Errror msg',
                    );
                }
              }
              return Container();
            }));
  }

  Widget _listpost(CategoryDetailsModel categoryDetailsModel) {
    alldata = categoryDetailsModel.categoryDetailData;
    allphotos = alldata['photos_post'];

    return Column(
      children: [
        ListOfPosts(
            refreshController: refreshController,
            posts: allphotos,
            url: 'demo2/app_api.php?application=phone&type=get_group_data'),
      ],
    );
  }
}
