import 'package:bettersolver/bloc/my_activities_bloc.dart';
import 'package:bettersolver/models/my_activities_model.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityScreen extends StatefulWidget {
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  MyActivitesBloc? _myActivitesBloc;

  GlobalKey<State> _keyLoader = new GlobalKey<State>();

  List myactivitiesList = [];

  String profileimage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shared();

    _myActivitesBloc = MyActivitesBloc(_keyLoader, context);

    // final timestamp1 =  1642772460; // timestamp in seconds
    // final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(timestamp1);
    // print('date1:::::::::::::::::::::$date1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhite,
        title: Text(
          'ACTIVITIES',
          style: Palette.greytext20B,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 210,
            width: MediaQuery.of(context).size.width,
            decoration: Palette.loginGradient,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0))),
                ),
                Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.only(top: 10),
                      decoration: Palette.RoundGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(
                                      profileimage))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 220),
              child: StreamBuilder(
                  stream: _myActivitesBloc!.myactivitiesblocDataStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(
                            loadingMessage: snapshot.data.message,
                          );
                          break;
                        case Status.COMPLETED:
                          return _followerList(snapshot.data.data);
                          break;
                        case Status.ERROR:
                          return Container(
                            child: Text(
                              'Errror msg',
                            ),
                          );
                          break;
                      }
                    }
                    return Container();
                  }))
        ],
      ),
    );
  }

  Widget _followerList(MyActivitesModel myActivitesModel) {
    myactivitiesList.addAll(myActivitesModel.activities);

    return ListView.builder(
        itemCount: myactivitiesList != null ? myactivitiesList.length : 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (Context, index) {
          var activator = myactivitiesList[index]['activator'];
          String image = activator['avatar'];
          String fnmae = activator['first_name'];
          String lname = activator['last_name'];

          // String time = myactivitiesList[index]['time'];
          // int timeInMillis = int.parse(time);

          // var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
          // var _date = date.minute;
          // int hours = timeInMillis ~/ 60;
          // int minutes = timeInMillis % 60;
          // String _time = TimeOfDay(hour: hours, minute: minutes).toString();
          // print('------------$hours');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //  color: kThemeColorLightGrey.withOpacity(0.2),
                // margin: EdgeInsets.only(bottom: 10),
                // padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(image),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '$fnmae $lname ',
                      style: Palette.blacktext14,
                    ),
                    Text(
                      ' reacted to post _time ',
                      style: Palette.greytext14,
                    ),
                    // Column(
                    //   children: [
                    //     Container(margin: EdgeInsets.only(top: 20),),
                    //     Container(
                    //       margin: EdgeInsets.only(right: 10),
                    //       alignment: Alignment.bottomRight,
                    //       child: Text('3 minutes ago',
                    //         style: Palette.greytext12,
                    //
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
              // SizedBox(height: 5,),
              Divider(
                thickness: 1,
              )
            ],
          );
        });
  }

  shared() async {
    SharedPreferences pef = await SharedPreferences.getInstance();
    setState(() {
      profileimage = pef.getString('profileimage')!;
    });
    print('$profileimage');
  }
}
