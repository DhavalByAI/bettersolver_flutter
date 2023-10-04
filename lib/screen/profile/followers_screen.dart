import 'package:bettersolver/bloc/follower_bloc.dart';
import 'package:bettersolver/models/follower_model.dart';
import 'package:bettersolver/screen/viewprofile/viewprofile_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowersScreen extends StatefulWidget {
  String? uid;

  FollowersScreen({this.uid});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  FollowerBloc? _followerBloc;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  List followerList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('widget.uid==${widget.uid}');

    _followerBloc = FollowerBloc(widget.uid!, _keyLoader, context);
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
          'FOLLOWERS',
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
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25))),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 40, right: 15),
            child: Container(
              width: MediaQuery.of(context).size.width / 1,
              height: 50,
              decoration: Palette.cardShapGradient,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(25))),
                  child: TextField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "SEARCH HERE",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintStyle: Palette.greytext12,
                      // labelText: "Email",
                      labelStyle: GoogleFonts.roboto(color: Color(0xFF424242)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: StreamBuilder(
                stream: _followerBloc!.followerblocDataStream,
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
                        return Text(
                          'Errror msg',
                        );
                        break;
                    }
                  }
                  return Container();
                }),
          )
        ],
      ),
    );
  }

  Widget _followerList(FollowerModel followerModel) {
    followerList.addAll(followerModel.followerData);

    return ListView.builder(
        itemCount: followerList != null ? followerList.length : 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (Context, index) {
          String profileimage = followerList[index]['profile_picture'];
          String name = followerList[index]['username'];
          String userid = followerList[index]['user_id'];
          return Container(
            color: kThemeColorLightGrey.withOpacity(0.2),
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewProfileScreen(
                              userviewid: userid,
                            )));
              },
              child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(profileimage),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    name,
                    style: Palette.greytext15,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
