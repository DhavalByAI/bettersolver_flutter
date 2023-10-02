import 'package:bettersolver/bloc/category_details_bloc.dart';
import 'package:bettersolver/models/category_details_model.dart';
import 'package:bettersolver/screen/category/category_detail_controller.dart';
import 'package:bettersolver/screen/category/timeline.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'c_card.dart';

class CategoryDetailScreen extends StatefulWidget {
  String? groupid;

  CategoryDetailScreen({super.key, this.groupid});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  CategoryDetailsBloc? _categoryDetailsBloc;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderjoin = GlobalKey<State>();
  final CategoryDetailController _ = Get.put(CategoryDetailController());
  @override
  void initState() {
    super.initState();
    _.groupid = widget.groupid!;
    _.fetchcategorydetails();
    _.update();
    _categoryDetailsBloc =
        CategoryDetailsBloc(widget.groupid!, _keyLoader, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: StreamBuilder(
            stream: _categoryDetailsBloc!.categorydetailsblocDataStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);

                  case Status.COMPLETED:
                    return _detailList(snapshot.data.data);

                  case Status.ERROR:
                    return const Text(
                      'Errror msg',
                    );
                }
              }
              return Container();
            }));
  }

  Widget _detailList(CategoryDetailsModel categoryDetailsModel) {
    return SingleChildScrollView(
        child: GetBuilder<CategoryDetailController>(
      initState: (_) {},
      builder: (_) {
        categoryDetailsModel = _.model;
        String image = categoryDetailsModel.categoryDetailData['avatar'];
        String coverimage = categoryDetailsModel.categoryDetailData['cover'];
        String groupname = categoryDetailsModel.categoryDetailData['name'];
        String totalmember =
            categoryDetailsModel.categoryDetailData['total_member'];
        String postcount =
            categoryDetailsModel.categoryDetailData['post_count'];
        String privacy = categoryDetailsModel.categoryDetailData['privacy'];
        bool isjoin = categoryDetailsModel.categoryDetailData['is_joined'];

        List timelinePosts =
            categoryDetailsModel.categoryDetailData['all_post'];
        List textPosts = categoryDetailsModel.categoryDetailData['text_post'];
        List photoPosts =
            categoryDetailsModel.categoryDetailData['photos_post'];
        List videoPosts = categoryDetailsModel.categoryDetailData['video_post'];

        String jointext = '';

        String privacytype = "";

        if (privacy.contains("1")) {
          privacytype = "Public";
        } else {
          privacytype = "Private";
        }

        if (isjoin) {
          jointext = "LEFT";
        } else {
          jointext = "JOIN";
        }

        return Column(
          children: [
            Container(
              height: 330,
              decoration: Palette.loginGradient,
              child: Stack(
                children: [
                  Container(
                    height: 315,
                    decoration: const BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0))),
                  ),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(coverimage),
                    )),
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 0, right: 20, top: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_outlined,
                                color: kWhite,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          const Spacer(),
                          // Expanded(
                          //     child: Text(
                          //   groupname,
                          //   style: Palette.whiettext18,
                          // )),
                          jointext == 'LEFT'
                              ? GestureDetector(
                                  onTap: () async {
                                    showAlertDialog(context: context);
                                  },
                                  child: cCard(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.verified_user_outlined,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              'Joined',
                                              style: Palette.whiteText15,
                                            )
                                          ],
                                        ),
                                      )),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    _.fetchjoingroup();
                                  },
                                  child: cCard(
                                      color: Colors.blue,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.add,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              'Join',
                                              style: Palette.whiteText15,
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                          // jointext == 'LEFT'
                          //     ? InkWell(
                          //         onTap: () async {

                          //         },
                          //         child: Container(
                          //             margin: const EdgeInsets.only(right: 10),
                          //             child: Text(
                          //               jointext,
                          //               style: Palette.whiteText15,
                          //             )),
                          //       )
                          //     : InkWell(
                          //         onTap: () {
                          //           _.fetchjoingroup();
                          //         },
                          //         child: Container(
                          //             margin: const EdgeInsets.only(right: 10),
                          //             child: Text(
                          //               jointext,
                          //               style: Palette.whiteText15,
                          //             )),
                          //       )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: Palette.RoundGradient,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: CachedNetworkImageProvider(image),
                                    // colorFilter: const ColorFilter.mode(
                                    //     Colors.black, BlendMode.color)
                                  )),
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 5),
                            //alignment: Alignment.bottomCenter,
                            child: Text(
                              groupname,
                              style: Palette.greytext18B,
                            )),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: Palette.RoundGradient,
                                height: 30,
                                width: 30,
                                child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/membericon.png'))),
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                // width: MediaQuery.of(context).size.width / 1.3,
                                height: 35,
                                width: 120,

                                decoration: Palette.cardShapGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: kWhite,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                              bottomRight:
                                                  Radius.circular(25))),
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 2),
                                          padding: const EdgeInsets.all(10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '$totalmember  MEMBERS',
                                            style: Palette.greytext9,
                                          ))),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              // Container(
                              //   decoration: Palette.RoundGradient,
                              //   height: 30,
                              //   width: 30,
                              //   child: Padding(
                              //       padding: const EdgeInsets.all(1.0),
                              //       child: Container(
                              //         decoration: BoxDecoration(
                              //             color: kWhite,
                              //             borderRadius:
                              //                 BorderRadius.circular(30),
                              //             image: const DecorationImage(
                              //                 image: AssetImage(
                              //                     'assets/images/publicicon.png'))),
                              //       )),
                              // ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              // Container(
                              //   // width: MediaQuery.of(context).size.width / 1.3,
                              //   width: 120,
                              //   height: 35,
                              //   decoration: Palette.cardShapGradient,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(1.0),
                              //     child: Container(
                              //         decoration: const BoxDecoration(
                              //             color: kWhite,
                              //             borderRadius: BorderRadius.only(
                              //                 topLeft: Radius.circular(30),
                              //                 bottomLeft: Radius.circular(30),
                              //                 bottomRight:
                              //                     Radius.circular(25))),
                              //         child: Container(
                              //             margin:
                              //                 const EdgeInsets.only(left: 2),
                              //             alignment: Alignment.centerLeft,
                              //             padding: const EdgeInsets.all(10),
                              //             child: Text(
                              //               privacytype,
                              //               style: Palette.greytext9,
                              //             ))),
                              //   ),
                              // ),
                              Container(
                                decoration: Palette.RoundGradient,
                                height: 30,
                                width: 30,
                                child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/posticon.png'))),
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                // width: MediaQuery.of(context).size.width / 1.3,
                                width: 120,
                                height: 35,
                                decoration: Palette.cardShapGradient,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: kWhite,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                              bottomRight:
                                                  Radius.circular(25))),
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 2),
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            '$postcount POSTS',
                                            style: Palette.greytext9,
                                          ))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(
                        //       top: 10, right: 10, left: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       // Container(
                        //       //   decoration: Palette.RoundGradient,
                        //       //   height: 30,
                        //       //   width: 30,
                        //       //   child: Padding(
                        //       //       padding: const EdgeInsets.all(1.0),
                        //       //       child: Container(
                        //       //         decoration: BoxDecoration(
                        //       //             color: kWhite,
                        //       //             borderRadius: BorderRadius.circular(30),
                        //       //             image: const DecorationImage(
                        //       //                 image: AssetImage(
                        //       //                     'assets/images/kandaicon.png'))),
                        //       //       )),
                        //       // ),
                        //       // const SizedBox(
                        //       //   width: 10,
                        //       // ),
                        //       // Container(
                        //       //   // width: MediaQuery.of(context).size.width / 1.3,
                        //       //   height: 30,
                        //       //   width: 120,
                        //       //   decoration: Palette.cardShapGradient,
                        //       //   child: Padding(
                        //       //     padding: const EdgeInsets.all(1.0),
                        //       //     child: Container(
                        //       //         decoration: const BoxDecoration(
                        //       //             color: kWhite,
                        //       //             borderRadius: BorderRadius.only(
                        //       //                 topLeft: Radius.circular(30),
                        //       //                 bottomLeft: Radius.circular(30),
                        //       //                 bottomRight: Radius.circular(25))),
                        //       //         child: Container(
                        //       //             margin: const EdgeInsets.only(left: 2),
                        //       //             padding: const EdgeInsets.all(10),
                        //       //             alignment: Alignment.centerLeft,
                        //       //             child: Text(
                        //       //               groupname,
                        //       //               style: Palette.greytext9,
                        //       //             ))),
                        //       //   ),
                        //       // ),

                        //       // Container(
                        //       //   decoration: Palette.RoundGradient,
                        //       //   height: 30,
                        //       //   width: 30,
                        //       //   child: Padding(
                        //       //       padding: const EdgeInsets.all(1.0),
                        //       //       child: Container(
                        //       //         decoration: BoxDecoration(
                        //       //             color: kWhite,
                        //       //             borderRadius:
                        //       //                 BorderRadius.circular(30),
                        //       //             image: const DecorationImage(
                        //       //                 image: AssetImage(
                        //       //                     'assets/images/addfriendicon.png'))),
                        //       //       )),
                        //       // ),
                        //       // const SizedBox(
                        //       //   width: 10,
                        //       // ),
                        //       // Container(
                        //       //   // width: MediaQuery.of(context).size.width / 1.3,
                        //       //   height: 35,
                        //       //   width: 120,

                        //       //   decoration: Palette.cardShapGradient,
                        //       //   child: Padding(
                        //       //     padding: const EdgeInsets.all(1.0),
                        //       //     child: Container(
                        //       //         decoration: const BoxDecoration(
                        //       //             color: kWhite,
                        //       //             borderRadius: BorderRadius.only(
                        //       //                 topLeft: Radius.circular(30),
                        //       //                 bottomLeft: Radius.circular(30),
                        //       //                 bottomRight:
                        //       //                     Radius.circular(25))),
                        //       //         child: Container(
                        //       //             margin:
                        //       //                 const EdgeInsets.only(left: 2),
                        //       //             padding: const EdgeInsets.all(10),
                        //       //             alignment: Alignment.centerLeft,
                        //       //             child: Text(
                        //       //               'ADD YOUR FRIEND',
                        //       //               style: Palette.greytext9,
                        //       //             ))),
                        //       //   ),
                        //       // ),

                        //       // const SizedBox(
                        //       //   width: 20,
                        //       // ),
                        //       // Container(
                        //       //   decoration: Palette.RoundGradient,
                        //       //   height: 30,
                        //       //   width: 30,
                        //       //   child: Padding(
                        //       //       padding: const EdgeInsets.all(1.0),
                        //       //       child: Container(
                        //       //         decoration: BoxDecoration(
                        //       //             color: kWhite,
                        //       //             borderRadius:
                        //       //                 BorderRadius.circular(30),
                        //       //             image: const DecorationImage(
                        //       //                 image: AssetImage(
                        //       //                     'assets/images/posticon.png'))),
                        //       //       )),
                        //       // ),
                        //       // const SizedBox(
                        //       //   width: 10,
                        //       // ),
                        //       // Container(
                        //       //   // width: MediaQuery.of(context).size.width / 1.3,
                        //       //   width: 120,
                        //       //   height: 35,
                        //       //   decoration: Palette.cardShapGradient,
                        //       //   child: Padding(
                        //       //     padding: const EdgeInsets.all(1.0),
                        //       //     child: Container(
                        //       //         decoration: const BoxDecoration(
                        //       //             color: kWhite,
                        //       //             borderRadius: BorderRadius.only(
                        //       //                 topLeft: Radius.circular(30),
                        //       //                 bottomLeft: Radius.circular(30),
                        //       //                 bottomRight:
                        //       //                     Radius.circular(25))),
                        //       //         child: Container(
                        //       //             margin:
                        //       //                 const EdgeInsets.only(left: 2),
                        //       //             alignment: Alignment.centerLeft,
                        //       //             padding: const EdgeInsets.all(10),
                        //       //             child: Text(
                        //       //               '$postcount POSTS',
                        //       //               style: Palette.greytext9,
                        //       //             ))),
                        //       //   ),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
              child: Row(
                children: [
                  Container(
                    decoration: Palette.RoundGradient,
                    height: 50,
                    width: 50,
                    child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          // height: 50,
                          // width: 50,

                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/timelinelist.png'))),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostsOfCategory(
                                        posts: timelinePosts,
                                        title: 'TimeLine',
                                      )));
                        },
                        child: _textDesign('TimeLine')),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
              child: Row(
                children: [
                  Container(
                    decoration: Palette.RoundGradient,
                    height: 50,
                    width: 50,
                    child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          // height: 50,
                          // width: 50,

                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/categoriesicon.png'),
                              )),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostsOfCategory(
                                        posts: textPosts,
                                        title: 'Text Post',
                                      )));
                        },
                        child: _textDesign('Text Post')),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
              child: Row(
                children: [
                  Container(
                    decoration: Palette.RoundGradient,
                    height: 50,
                    width: 50,
                    child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          // height: 50,
                          // width: 50,

                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/photoicon.png'))),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostsOfCategory(
                                        posts: photoPosts,
                                        title: 'Photos',
                                      )));
                        },
                        child: _textDesign('Photos')),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
              child: Row(
                children: [
                  Container(
                    decoration: Palette.RoundGradient,
                    height: 50,
                    width: 50,
                    child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          // height: 50,
                          // width: 50,

                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/videolisticon.png'))),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostsOfCategory(
                                        posts: videoPosts,
                                        title: 'Video',
                                      )));
                        },
                        child: _textDesign('Video')),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 15, top: 20, right: 15),
            //   child: Row(
            //     children: [
            //       Container(
            //         decoration: Palette.RoundGradient,
            //         height: 50,
            //         width: 50,
            //         child: Padding(
            //             padding: const EdgeInsets.all(1.0),
            //             child: Container(
            //               // height: 50,
            //               // width: 50,

            //               decoration: BoxDecoration(
            //                   color: kWhite,
            //                   borderRadius: BorderRadius.circular(30),
            //                   image: DecorationImage(
            //                       image: AssetImage(
            //                           'assets/images/musiclisticon.png'))),
            //             )),
            //       ),
            //       SizedBox(width: 10),
            //       Expanded(
            //         child: InkWell(
            //             onTap: () {
            //               Navigator.push(context,
            //                   MaterialPageRoute(builder: (context) => Music()));
            //             },
            //             child: _textDesign('Music')),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: 15, top: 20, right: 15),
            //   child: Row(
            //     children: [
            //       Container(
            //         decoration: Palette.RoundGradient,
            //         height: 50,
            //         width: 50,
            //         child: Padding(
            //             padding: const EdgeInsets.all(1.0),
            //             child: Container(
            //               // height: 50,
            //               // width: 50,

            //               decoration: BoxDecoration(
            //                   color: kWhite,
            //                   borderRadius: BorderRadius.circular(30),
            //                   image: DecorationImage(
            //                       image: AssetImage(
            //                           'assets/images/filelisticon.png'))),
            //             )),
            //       ),
            //       SizedBox(width: 10),
            //       Expanded(
            //         child: InkWell(
            //             onTap: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => Documnet()));
            //             },
            //             child: _textDesign('Documnet')),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            // margin: EdgeInsets.only(left: 15, top: 20, right: 15),
            // child: Row(
            //   children: [
            //     Container(
            //       decoration: Palette.RoundGradient,
            //       height: 50,
            //       width: 50,
            //       child: Padding(
            //           padding: const EdgeInsets.all(1.0),
            //           child: Container(
            //             // height: 50,
            //             // width: 50,

            //             decoration: BoxDecoration(
            //                 color: kWhite,
            //                 borderRadius: BorderRadius.circular(30),
            //                 image: DecorationImage(
            //                     image: AssetImage(
            //                         'assets/images/locationlisticon.png'))),
            //           )),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: InkWell(
            //           onTap: () {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => Location()));
            //           },
            //           child: _textDesign('Location')),
            //     ),
            //   ],
            // ),
            // ),
            const SizedBox(height: 30)
          ],
        );
      },
    ));
  }

  Widget _textDesign(String text) {
    return Container(
      // width: MediaQuery.of(context).size.width / 1.3,
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
            child: Container(
                margin: const EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: Palette.greytext12,
                ))),
      ),
    );
  }

  showAlertDialog({required BuildContext context}) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      child: Text(
        "Cancel",
        style: GoogleFonts.reemKufi(fontSize: 14.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = GetBuilder<CategoryDetailController>(
      initState: (_) {},
      builder: (_) {
        return MaterialButton(
          child: Text(
            "Yes",
            style: GoogleFonts.reemKufi(fontSize: 14.0, color: Colors.black),
          ),
          onPressed: () async {
            Get.back();
            _.fetchjoingroup();
          },
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title:Text("Logout"),
      content: const Text("Are you sure you want to left Group?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
