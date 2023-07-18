import 'package:bettersolver/bloc/blocked_bloc.dart';
import 'package:bettersolver/bloc/blocked_list_bloc.dart';
import 'package:bettersolver/models/blocked_list_model.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlockUserScreen extends StatefulWidget {
  const BlockUserScreen({super.key});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends State<BlockUserScreen> {
  BlockedListBloc? _blockedListBloc;
  TextEditingController searchController = TextEditingController();
  final GlobalKey<State> _keyLoaderget = GlobalKey<State>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderforloder = GlobalKey<State>();

  List blockedList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blockedListBloc = BlockedListBloc(_keyLoaderget, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        title: Text(
          'BLOCKED USER',
          style: Palette.greytext20B,
        ),
        centerTitle: true,
        // actions: [
        //   InkWell(
        //     onTap: (){
        //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SecurityScreen()));
        //     },
        //     child: Container(
        //       height: 50,
        //       width: 50,
        //       margin: EdgeInsets.only(right: 5),
        //       decoration: BoxDecoration(
        //           image: DecorationImage(
        //               fit: BoxFit.cover,
        //               image: AssetImage('assets/images/checkicon.png')
        //           )
        //       ),
        //     ),
        //   )
        // ],
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
          // Container(
          //   margin: EdgeInsets.only(left: 15, top: 40, right: 15),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width / 1,
          //     height: 50,
          //     decoration: Palette.cardShapGradient,
          //     child: Padding(
          //       padding: const EdgeInsets.all(1.0),
          //       child: Container(
          //         decoration: BoxDecoration(
          //             color: kWhite,
          //             borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(30),
          //                 bottomLeft: Radius.circular(30),
          //                 bottomRight: Radius.circular(25))),
          //         child: TextField(
          //           controller: searchController,
          //           keyboardType: TextInputType.text,
          //           decoration: InputDecoration(
          //             hintText: "SEARCH HERE",
          //             prefixIcon: Icon(
          //               Icons.search,
          //               color: Colors.grey,
          //             ),
          //             hintStyle: Palette.greytext12,
          //             // labelText: "Email",
          //             labelStyle:
          //                 GoogleFonts.reemKufi(color: const Color(0xFF424242)),
          //             enabledBorder: OutlineInputBorder(
          //               borderSide:
          //                   BorderSide(color: Colors.transparent, width: 1),
          //               borderRadius: BorderRadius.circular(30.0),
          //             ),
          //             focusedBorder: OutlineInputBorder(
          //               borderSide:
          //                   BorderSide(color: Colors.transparent, width: 1),
          //               borderRadius: BorderRadius.circular(30.0),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Container(
              margin: const EdgeInsets.only(top: 30),
              child: StreamBuilder(
                  stream: _blockedListBloc!.blockedlistblocStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(
                            loadingMessage: snapshot.data.message,
                          );
                          break;
                        case Status.COMPLETED:
                          return _suerList(snapshot.data.data);
                          break;
                        case Status.ERROR:
                          return Container(
                            child: const Text(
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

  Widget _suerList(BlockedListModel blockedListModel) {
    blockedList.clear();
    blockedList.addAll(blockedListModel.blocked_users);

    return blockedList.isNotEmpty
        ? ListView.builder(
            itemCount: blockedList != null ? blockedList.length : 0,
            // primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String profile = blockedList[index]['profile_picture'];
              String name = blockedList[index]['name'];
              String username = blockedList[index]['username'];
              String time = blockedList[index]['lastseen_time_text'];
              String id = blockedList[index]['user_id'];

              return Container(
                height: 60,
                margin: const EdgeInsets.only(bottom: 10),
                decoration:
                    BoxDecoration(color: kThemeColorLightGrey.withOpacity(0.2)),
                child: Row(
                  children: [
                    Container(
                      // height: 50,
                      // width: 50,
                      margin: const EdgeInsets.only(left: 10),
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: AssetImage('assets/images/photo.png')
                      //     )
                      // ),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: CachedNetworkImageProvider(profile),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: Palette.greyDarktext12
                                .copyWith(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            '@$username',
                            style: Palette.greyDarktext12,
                          ),
                          Text(
                            '  $time',
                            style: Palette.greytext9,
                          ),
                        ],
                      ),
                    ),
                    _gradientBtn(id)
                  ],
                ),
              );
            })
        : Center(
            child: Container(
              child: Text(
                'No Users to show\n\n\n',
                style: Palette.greyDarktext12.copyWith(fontSize: 16),
              ),
            ),
          );
  }

  Widget _gradientBtn(String id) {
    return Container(
      width: 60,
      height: 25,
      margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      decoration: Palette.buttonGradient,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Home()));
          LoadingDialog.showLoadingDialog(context, _keyLoaderforloder);

          BlockedBloc(id, 'un-block', _keyLoader, context, "User Un-Blocked");
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "UNBLOCK",
              style: Palette.whiettext8,
            ),
          ),
        ),
      ),
    );
  }
}
