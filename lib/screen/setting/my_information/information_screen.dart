import 'dart:convert';

import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import '../../../utils/base_constant.dart';
import 'package:open_file/open_file.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  bool info = false;
  bool posts = false;
  bool cat = false;
  bool following = false;
  bool follower = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        title: Text(
          'MY INFORMATION',
          style: Palette.greytext20B,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              download();
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
            },
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(right: 5),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/downloadicon.png'))),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                'Please choose which information you would like to download',
                style: Palette.greytext14,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(child: _information()),
              const SizedBox(
                width: 20,
              ),
              Expanded(child: _posts()),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(child: _categories()),
              const SizedBox(
                width: 20,
              ),
              Expanded(child: _following()),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          _followers()
        ],
      ),
    );
  }

  download() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userid');
    var s = pref.getString('s');

    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=myinformation';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId,
          's': s,
          'my_information': (info ? 1 : 0).toString(),
          'posts': (posts ? 1 : 0).toString(),
          'groups': (cat ? 1 : 0).toString(),
          'following': (following ? 1 : 0).toString(),
          'followers': (follower ? 1 : 0).toString(),
        },
      );

      var decode = json.decode(response.body);
      print(decode);

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        if (decode['api_status'] == '200') {
          //----> here     // downloadLink = decode['link'];

          setState(() {});
          // EasyLoading.showSuccess(decode['data']);
          FileDownloader.downloadFile(
              url: decode['link'],
              onDownloadCompleted: (path) {
                print(path);
                EasyLoading.showSuccess("Downloaded");
                OpenFile.open(path);
              });
        } else {
          EasyLoading.showError("Something Went Wrong");
        }
      } else {}
    } catch (e) {
      EasyLoading.showError("Something Went Wrong");
    }
  }

  ///first row
  Widget _information() {
    return InkWell(
      onTap: () {
        setState(() {
          info = !info;
        });
      },
      child: Card(
        elevation: 8,
        color: kWhite,
        margin: const EdgeInsets.only(left: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [kThemeColorBlue, kThemeColorGreen]),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: info == true
                  ? const EdgeInsets.all(4)
                  : const EdgeInsets.all(0.9),
              child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 32,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'My Information',
                        style: Palette.greytext12
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )),
            )),
      ),
    );
  }

  Widget _posts() {
    return InkWell(
      onTap: () {
        setState(() {
          posts = !posts;
        });
      },
      child: Card(
        elevation: 8,
        color: kWhite,
        margin: const EdgeInsets.only(right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [kThemeColorBlue, kThemeColorGreen]),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: posts == true
                  ? const EdgeInsets.all(4)
                  : const EdgeInsets.all(0.9),
              child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.photo_album_sharp,
                        size: 32,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'My Posts',
                        style: Palette.greytext12
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )),
            )),
      ),
    );
  }

  ///second row
  Widget _categories() {
    return InkWell(
      onTap: () {
        setState(() {
          cat = !cat;
        });
      },
      child: Card(
        elevation: 8,
        color: kWhite,
        margin: const EdgeInsets.only(left: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [kThemeColorBlue, kThemeColorGreen]),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: cat == true
                  ? const EdgeInsets.all(4)
                  : const EdgeInsets.all(0.9),
              child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.category,
                        size: 32,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Categories',
                        style: Palette.greytext12
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )),
            )),
      ),
    );
  }

  Widget _following() {
    return InkWell(
      onTap: () {
        setState(() {
          following = !following;
        });
      },
      child: Card(
        elevation: 8,
        color: kWhite,
        margin: const EdgeInsets.only(right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [kThemeColorBlue, kThemeColorGreen]),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: following == true
                  ? const EdgeInsets.all(4)
                  : const EdgeInsets.all(0.9),
              child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_add_alt_1,
                        size: 32,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Following',
                        style: Palette.greytext12
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )),
            )),
      ),
    );
  }

  /// last row
  Widget _followers() {
    return InkWell(
      onTap: () {
        setState(() {
          follower = !follower;
        });
      },
      child: Card(
        elevation: 8,
        color: kWhite,
        margin: const EdgeInsets.only(left: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
            width: MediaQuery.of(context).size.width / 2.3,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [kThemeColorBlue, kThemeColorGreen]),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: follower == true
                  ? const EdgeInsets.all(4)
                  : const EdgeInsets.all(0.9),
              child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.people_sharp,
                        size: 32,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Followers',
                        style: Palette.greytext12
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )),
            )),
      ),
    );
  }
}
