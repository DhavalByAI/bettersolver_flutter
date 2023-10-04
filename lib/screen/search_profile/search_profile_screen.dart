import 'package:bettersolver/bloc/search_bloc.dart';
import 'package:bettersolver/bottom_navigation.dart';
import 'package:bettersolver/models/search_model.dart';
import 'package:bettersolver/screen/viewprofile/viewprofile_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchProfileScreen extends StatefulWidget {
  const SearchProfileScreen({super.key});

  @override
  State<SearchProfileScreen> createState() => _SearchProfileScreenState();
}

class _SearchProfileScreenState extends State<SearchProfileScreen> {
  TextEditingController searchController = TextEditingController();

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  String serach = "''";

  SearchBLoc? _searchBLoc;

  List? userList = [];

  bool isfirstload = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchBLoc = SearchBLoc("normal", serach, _keyLoader, context);
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
          elevation: 0,
          centerTitle: true,
          backgroundColor: kWhite,
          title: Text(
            'Search',
            style: GoogleFonts.reemKufi(
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              color: kThemeColorGrey,
            ),
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
              margin: const EdgeInsets.only(left: 15, top: 40, right: 15),
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
                        labelStyle:
                            GoogleFonts.roboto(color: const Color(0xFF424242)),
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
                      onChanged: (newvalue) {
                        setState(() {
                          isfirstload = false;
                          serach = newvalue;

                          //  SearchBLoc("normal", serach, _keyLoader, context);
                          _searchBLoc =
                              SearchBLoc("normal", serach, _keyLoader, context);
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 90),
                child: StreamBuilder(
                    stream: _searchBLoc!.searchblocDataStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            return Loading(
                                loadingMessage: snapshot.data.message);
                            break;
                          case Status.COMPLETED:
                            return _userList(snapshot.data.data);
                            break;
                          case Status.ERROR:
                            return const Text(
                              'Errror msg',
                            );
                            break;
                        }
                      }
                      return Container();
                    }))
          ],
        ),
      ),
    );
  }

  Widget _userList(SearchModel searchModel) {
    userList = searchModel.user;

    return GridView.builder(
      itemCount: userList != null ? userList!.length : 0,
      primary: false,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 8 / 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        String userId = userList![index]['id'];
        String image = userList![index]['avatar'];
        String name = userList![index]['username'];
        String postnumber = userList![index]['details']['post_count'];
        String followernumber = userList![index]['details']['followers_count'];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewProfileScreen(
                            userviewid: userId,
                          )));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(image))),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(colors: [
                    Colors.black87,
                    Colors.black38,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
                // margin:
                //     const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(
                          name,
                          style: Palette.whiteText15,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor:
                                kThemeColorLightGrey.withOpacity(0.4),
                            child: Text(
                              postnumber,
                              style: Palette.whiteText12,
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                'post',
                                style: Palette.whiteText12,
                              )),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor:
                                kThemeColorLightGrey.withOpacity(0.4),
                            child: Text(
                              followernumber,
                              style: Palette.whiteText12,
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                'Followers',
                                style: Palette.whiteText12,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
