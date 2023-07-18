import 'package:bettersolver/screen/category/category_screen.dart';
import 'package:bettersolver/screen/notification/notification_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:flutter/material.dart';
import 'screen/create_post/create_post_screen.dart';
import 'screen/home_Screen_getx.dart';
import 'screen/search_profile/search_profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  List<Widget> _children = [];
  List<String> icon = [
    'assets/images/homewhite.png',
    'assets/images/searchwhite.png',
    'assets/images/creatpostwhite.png',
    'assets/images/categorywhite.png',
    'assets/images/notificationwhite.png',
  ];

  List<String> selectedIcon = [
    'assets/images/home.png',
    'assets/images/searchwhite.png',
    'assets/images/creatpost.png',
    'assets/images/category.png',
    'assets/images/notification.png',
  ];

  @override
  void initState() {
    super.initState();
    _children = [
      const GetHomeScreen(),
      const SearchProfileScreen(),
      const CreatePostScreen(),
      const CategoryScreen(),
      const NotificationBottomScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        // backgroundColor: kWhite,

        body: _children[currentIndex],
        bottomNavigationBar: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
              color: kThemeColorLightBlue,
              borderRadius: BorderRadius.circular(0),
              // border: Border.all(color: kWhite, width: 2),
              boxShadow: [
                BoxShadow(
                    color: kThemeColorGrey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0.0, 5.0))
              ]),
          child: Container(
            // margin: const EdgeInsets.only(left: 10, right: 10),
            // alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      _children.length,
                      (index) => InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                currentIndex != index
                                    ? selectedIcon[index]
                                    : icon[index],
                                height: 25,
                                width: 25,
                              ),
                            ),
                          ))),
            ),
          ),
        ));
  }

  Widget _virticalDivider() {
    return Container(
        margin: const EdgeInsets.only(top: 15, bottom: 15),
        child: VerticalDivider(
          thickness: 1,
          color: Colors.black45.withOpacity(0.2),
        ));
  }
}