import 'dart:convert';
import 'dart:io';

import 'package:bettersolver/bloc/userdetail_bloc.dart';
import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/base_constant.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:images_picker/images_picker.dart';
import 'package:dio/dio.dart' as dio;

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoverPageScreen extends StatefulWidget {
  const CoverPageScreen({super.key});

  @override
  State<CoverPageScreen> createState() => _CoverPageScreenState();
}

class _CoverPageScreenState extends State<CoverPageScreen> {
  UserDetailBloc? _userDetailBloc;

  final GlobalKey<State> _keyLoaderget = GlobalKey<State>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyError = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderforloder = GlobalKey<State>();

  List<Media>? coverFile;
  var coverImg;

  List<Media>? profileFile;
  var profileImg;

  String? profile;
  String? cover;
  String? username;

  String? _imgFilePath;

  String? _imgFileFormate;
  String? _logoImg;

  String? _imgFilePathcover;

  @override
  void initState() {
    super.initState();
    _userDetailBloc = UserDetailBloc(_keyLoaderget, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: StreamBuilder(
          stream: _userDetailBloc!.userdetailblocDataStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                case Status.COMPLETED:
                  return _detail(snapshot.data.data);
                case Status.ERROR:
                  return Container(
                    child: const Text(
                      'Errror msg',
                    ),
                  );
              }
            }
            return Container();
          },
        ));
  }

  Widget _detail(UserDetailModel userDetailModel) {
    profile = userDetailModel.user_data['avatar'];
    cover = userDetailModel.user_data['cover'];
    username = userDetailModel.user_data['username'];
    return Column(
      children: [
        Container(
          height: 400,
          decoration: Palette.loginGradient,
          child: Stack(
            children: [
              Container(
                height: 380,
                decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0))),
              ),
              cover != null && coverFile == null
                  ? InkWell(
                      onTap: () {
                        getImgFilePathcover();
                      },
                      child: Container(
                        height: 260,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(cover!))),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        getImgFilePathcover();
                      },
                      child: Container(
                        height: 260,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    FileImage(File(coverFile![0].thumbPath!)))),
                      ),
                    ),
              Container(
                margin: const EdgeInsets.only(left: 0, right: 20, top: 40),
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
                      width: 50,
                    ),
                    Container(
                        child: Text(
                      'DISPLAY & COVER PHOTO',
                      style: Palette.whitetext20,
                    ))
                  ],
                ),
              ),
              Positioned(
                top: 180,
                left: 120,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: Palette.RoundGradient,
                      child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: profile != null && profileFile == null
                              ? InkWell(
                                  onTap: () {
                                    getImgFilePath();
                                  },
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        CachedNetworkImageProvider(profile!),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    getImgFilePath();
                                  },
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: FileImage(
                                        File(profileFile![0].thumbPath!)),
                                  ),
                                )),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        //alignment: Alignment.bottomCenter,
                        child: Text(
                          '$username',
                          style: Palette.greytext18B,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        _gradientBtn(),
      ],
    );
  }

  void getImgFilePath() async {
    final permissionStatus = await Permission.storage.request();
    if (permissionStatus.isDenied) {
      print("permission denied will ask");
      await Permission.storage.request();
      if (permissionStatus.isDenied) {
        print("permission denied");
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      print("permission isPermanentlyDenied");
      await openAppSettings();
    } else {
      print("permission else field");
    }

    List<Media>? result = await ImagesPicker.pick(
        count: 1, pickType: PickType.image, cropOpt: CropOption(), gif: false);

    if (result != null) {
      setState(() {
        profileFile = result;
      });
    }
    profileImg = await dio.MultipartFile.fromFile(
        File(profileFile![0].path).path,
        filename: File(profileFile![0].path).path);
    setState(() {});
  }

  void getImgFilePathcover() async {
    final permissionStatus = await Permission.storage.request();
    if (permissionStatus.isDenied) {
      print("permission denied will ask");
      await Permission.storage.request();
      if (permissionStatus.isDenied) {
        print("permission denied");
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      print("permission isPermanentlyDenied");
      await openAppSettings();
    } else {
      print("permission else field");
    }

    List<Media>? result = await ImagesPicker.pick(
        count: 1, pickType: PickType.image, cropOpt: CropOption(), gif: false);

    if (result != null) {
      setState(() {
        coverFile = result;
      });
    }
    coverImg = await dio.MultipartFile.fromFile(File(coverFile![0].path).path,
        filename: File(coverFile![0].path).path);
    setState(() {});
    // try {
    //   // String filePath = (await FilePicker.platform) as String;
    //   // FilePickerResult? filePath = await FilePicker.platform.pickFiles(type: FileType.image);
    //   List<Media>? result = await ImagesPicker.pick(
    //     count: 1,
    //     cropOpt: CropOption(),
    //     gif: false,
    //     pickType: PickType.image,
    //   );
    //   var file0 = await FilePicker.platform.pickFiles();
    //   var file = file0!.files.first.name;
    //   var filepath = file0.files.first.path;

    //   if (filepath == '') {
    //     return;
    //   }
    //   print("File path-+++++++++++++++++++++--:  $file");
    //   print("File path--------------------------:  $filepath");
    //   setState(() {
    //     _imgFilePathcover = filepath;
    //     _imgFileName = file;

    //     final extension = p.extension(filepath!, 2);
    //     _imgFileFormatecover = extension;

    //     _imgFileNamecover = filepath.split('/').last;

    //     print('===============$_imgFileNamecover');

    //     //_uploadImage();
    //   });
    // } on PlatformException catch (e) {
    //   print("Error while picking the file: $e");
    // }
  }

  Widget _gradientBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: Palette.buttonGradient,
      child: InkWell(
        onTap: () {
          _addphotoApi();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "SAVE",
              style: Palette.whiettext18,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addphotoApi() async {
    EasyLoading.show();
    var pref = await SharedPreferences.getInstance();
    var userid = pref.getString("userid");
    var sid = pref.getString("s");
    Map<String, dynamic> params = {
      'user_id': userid!,
      's': sid!,
      'profile': profileImg,
      'cover': coverImg
    };
    print(params);
    try {
      // var request = http.MultipartRequest(
      //   "POST",
      //   Uri.parse(
      //       '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=display'),
      // );
      dio.Response response = await dio.Dio().post(
        '${BaseConstant.BASE_URL_DEMO}${BaseConstant.BASE_URL_PARAMS}display',
        data: dio.FormData.fromMap(params),
      );
      print(response);
      var res = json.decode(response.toString());
      print('response::::::::::::$response');
      if (res['api_status'] == 200) {
        EasyLoading.showSuccess("Successfully Uploaded");
      } else {
        EasyLoading.showError("Something Went Wrong");
      }
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      EasyLoading.dismiss();
      // ErrorDialouge.showErrorDialogue(context, _keyError, e.toString());
      print("Exeption $e");
    }
  }
}
