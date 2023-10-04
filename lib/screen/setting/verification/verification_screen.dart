import 'dart:convert';
import 'dart:io';

import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart' as dio;

import '../../../utils/base_constant.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  String profileimage = '';

  String? _imgFilePath;
  String? _imgFileName;
  String? _imgFileFormate;
  String? _logoImg;

  String? _imgFilePathphoto;
  String? _imgFileNamephoto;
  String? _imgFileFormatephoto;
  String? _logoImgphoto;
  String? userName;
  String? fullName;
  String? avtarURL;
  String? coverURL;
  var postValue;
  var postValue2;

  @override
  void initState() {
    super.initState();
    getShared();
  }

  @override
  Widget build(BuildContext context) {
    usernameController.text = userName ?? '';
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        title: Text(
          'VERIFICATION',
          style: Palette.greytext20B,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              postValue != null ? getAPI() : null;
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => SettingScreen()));
            },
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(right: 5),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/checkicon.png'))),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 270,
              width: MediaQuery.of(context).size.width,
              decoration: Palette.loginGradient,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
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
                        margin: const EdgeInsets.only(top: 30),
                        decoration: Palette.RoundGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(avtarURL ?? ""))),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          //alignment: Alignment.bottomCenter,
                          child: Text(
                            fullName ?? "",
                            style: Palette.greytext18B,
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          //alignment: Alignment.bottomCenter,
                          child: Text(
                            '@$userName',
                            style: Palette.greytext14,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            _usernameTextField(),
            // const SizedBox(
            //   height: 20,
            // ),
            // _messageField(),
            const SizedBox(
              height: 30,
            ),
            _idphoto(),
            _idphotoget(),
            const SizedBox(
              height: 30,
            ),
            _profilephoto(),
            __profilephotoget(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _usernameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: GradientText(
            'USERNAME',
            style: Palette.whiteText10,
            colors: const [kThemeColorBlue, kThemeColorGreen],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: usernameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "user name",
              hintStyle: Palette.greytext12,

              // labelText: "Email",
              hintMaxLines: 2,
              labelStyle: GoogleFonts.roboto(color: const Color(0xFF424242)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget _messageField() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         margin: const EdgeInsets.only(left: 10),
  //         child: GradientText(
  //           'MESSAGE',
  //           style: Palette.whiteText10,
  //           colors: const [kThemeColorBlue, kThemeColorGreen],
  //         ),
  //       ),
  //       Container(
  //         margin: const EdgeInsets.only(left: 15, right: 15),
  //         width: MediaQuery.of(context).size.width,
  //         child: TextField(
  //           controller: messageController,
  //           keyboardType: TextInputType.text,
  //           decoration: InputDecoration(
  //             hintText: "message",
  //             hintStyle: Palette.greytext12,
  //             // labelText: "Email",
  //             labelStyle: GoogleFonts.roboto(color: const Color(0xFF424242)),
  //             enabledBorder: const UnderlineInputBorder(
  //               borderSide: BorderSide(color: Colors.grey, width: 1),
  //               // borderRadius: BorderRadius.circular(30.0),
  //             ),
  //             focusedBorder: const UnderlineInputBorder(
  //               borderSide: BorderSide(color: Colors.grey, width: 1),
  //               // borderRadius: BorderRadius.circular(30.0),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  /// first photo select
  Widget _idphoto() {
    return Visibility(
      visible: _imgFilePath == null,
      child: Card(
        elevation: 8,
        color: kWhite,
        margin: const EdgeInsets.only(left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [kThemeColorBlue, kThemeColorGreen]),
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(0.9),
              child: Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(height: 20,),
                      // Text('ADD PHOTO',style: Palette.blackText30,),
                      // SizedBox(height: 10,),
                      const SizedBox(height: 30),

                      roundedRectBorderWidgetForId,
                      const SizedBox(height: 20),
                      Text(
                        'Copy of Your Passport or Id Card',
                        style: Palette.greytext12,
                      ),
                    ],
                  )),
            )),
      ),
    );
  }

  Widget _idphotoget() {
    return Visibility(
      visible: _imgFilePath != null,
      child: Card(
        elevation: 8,
        color: kWhite,
        margin: const EdgeInsets.only(left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [kThemeColorBlue, kThemeColorGreen]),
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(0.9),
              child: Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kWhite, borderRadius: BorderRadius.circular(50)),
                child: _imgFilePath != null && _imgFileFormate == '.jpg' ||
                        _imgFileFormate == '.png' ||
                        _imgFileFormate == '.jpeg'
                    ? InkWell(
                        onTap: () {
                          getImgFilePath();
                        },
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45)),
                          color: Colors.black12,
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: 140.0,
                            // width: 140.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.file(
                              File(_imgFilePath!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          getImgFilePath();
                        },
                        child: const CircleAvatar(
                          radius: 60,
                          backgroundColor: kWhite,
                          backgroundImage: AssetImage('_logoImg'),
                        ),
                      ),
              ),
            )),
      ),
    );
  }

  Widget get roundedRectBorderWidgetForId {
    return DottedBorder(
        borderType: BorderType.RRect,
        //strokeCap: StrokeCap.round,
        dashPattern: const [8, 8],
        strokeWidth: 2,
        radius: const Radius.circular(80),
        padding: const EdgeInsets.all(6),
        color: kThemeColorBlue,
        child:
            // _imgFilePath == null
            //     ?
            InkWell(
          onTap: () {
            getImgFilePath();
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                //color: Colors.amber,
                borderRadius: BorderRadius.circular(60),
                image: const DecorationImage(
                    image: AssetImage('assets/images/addphotosmall.png'))),
          ),
        )
        // // : _imgFilePath == null && _logoImg == null
        // //     ? CircleAvatar(
        // //         radius: 40,
        // //         backgroundColor: Colors.grey[300],
        // //         child: IconButton(
        // //           onPressed: () {
        // //           //  getImgFilePath();
        // //           },
        // //           icon: const Icon(
        // //               Icons.add_circle_outline,
        // //               size: 28),
        // //         ),
        // //       )
        //     : _imgFilePath != null &&
        //     _imgFileFormate == '.jpg' ||
        //     _imgFileFormate == '.png' ||
        //     _imgFileFormate == '.jpeg'
        //     ? InkWell(
        //   onTap: (){
        //     getImgFilePath();
        //
        //   },
        //   child: CircleAvatar(
        //     radius: 40,
        //     // height: 130.0,
        //     // width: 130.0,
        //     // decoration: BoxDecoration(
        //     //   borderRadius: BorderRadius.circular(50),
        //     // ),
        //     //   backgroundImage: CachedNetworkImageProvider(_imgFilePath),
        //     backgroundImage: FileImage(
        //         File(_imgFilePath)),
        //     // child: Image.file(
        //     //   File(_imgFilePath),
        //     //   fit: BoxFit.contain,
        //     // ),
        //   ),
        // )
        //     : InkWell(
        //   onTap: () {},
        //   child: CircleAvatar(
        //     radius: 30.0,
        //     backgroundColor: kWhite,
        //     backgroundImage:
        //     CachedNetworkImageProvider(_logoImg),
        //   ),
        // ),
        // // Container(
        // //   height: 70,
        // //   width: 70,
        // //   decoration: BoxDecoration(
        // //       //color: Colors.amber,
        // //       borderRadius: BorderRadius.circular(60),
        // //       image: DecorationImage(
        // //           image: AssetImage('assets/images/addphotosmall.png'))),
        // // ),
        );
  }

  // void getImgFilePath() async {
  //   try {
  //     String filePath = await FilePicker.getFilePath();
  //     // String filePath = await FilePicker.
  //
  //     if (filePath == '') {
  //       return;
  //     }
  //     print("File path: " + filePath);
  //     setState(() {
  //       _imgFilePath = filePath;
  //
  //       final _extension = p.extension(filePath, 2);
  //       this._imgFileFormate = _extension;
  //
  //       print(':::::::::::::::::$_imgFilePath:::::::::::::::');
  //       print(':::::::::::::::::$_extension:::::::::::::::');
  //
  //       _imgFileName = filePath.split('/').last;
  //       print(':::::::::::::::::$_imgFileName:::::::::::::::');
  //
  //       //_uploadImage();
  //     });
  //   } on PlatformException catch (e) {
  //     print("Error while picking the file: " + e.toString());
  //   }
  // }
  void getImgFilePath() async {
    try {
      // String filePath = (await FilePicker.platform) as String;
      // FilePickerResult? filePath = await FilePicker.platform.pickFiles(type: FileType.image);
      var file0 = await FilePicker.platform.pickFiles();
      var file = file0!.files.first.name;
      var filepath = file0.files.first.path;

      print("File path-+++++++++++++++++++++--:  $file");
      print("File path--------------------------:  $filepath");
      _imgFilePath = filepath;

      postValue = await dio.MultipartFile.fromFile(File(_imgFilePath!).path,
          filename: File(_imgFilePath!).path);
      setState(() {
        _imgFileName = file;

        final extension = p.extension(filepath!, 2);
        _imgFileFormate = extension;

        _imgFileName = filepath.split('/').last;

        print('===============$_imgFilePath');

        //_uploadImage();
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: $e");
    }
  }

  getAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    try {
      Map<String, dynamic> params = {
        "user_id": userid,
        "s": s,
        "username": usernameController.text.toString(),
        'message': 'no message',
        'pic1': postValue,
        'pic2': postValue2
      };

      print(params);

      dio.Response response = await dio.Dio().post(
        '${BaseConstant.BASE_URL_DEMO}${BaseConstant.BASE_URL_PARAMS}verification',
        data: dio.FormData.fromMap(params),
      );
      print(response);
      var res = json.decode(response.toString());

      if (res['api_status'] == 200) {
        EasyLoading.showSuccess("Uploaded Successfully",
            duration: const Duration(milliseconds: 1000),
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true);
        Get.back();
        return;
      } else {
        EasyLoading.showError(res['errors'],
            duration: const Duration(milliseconds: 1000),
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true);
      }
    } catch (e) {
      EasyLoading.showError("Something Went Wrong");
    }
    _imgFilePath = null;
    _imgFileName = null;
    _imgFileFormate = null;
    _logoImg = null;
    _imgFilePathphoto = null;
    _imgFileNamephoto = null;
    setState(() {});
  }

  /// second photo select
  Widget _profilephoto() {
    return Visibility(
      visible: _imgFilePathphoto == null,
      child: Card(
        elevation: 8,
        color: kWhite,
        margin: const EdgeInsets.only(left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [kThemeColorBlue, kThemeColorGreen]),
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(0.9),
              child: Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(height: 20,),
                      // Text('ADD PHOTO',style: Palette.blackText30,),
                      // SizedBox(height: 10,),
                      const SizedBox(height: 30),

                      roundedRectBorderWidgetForProfile,
                      const SizedBox(height: 20),
                      Text(
                        'Any Other Identity Document of Yours',
                        style: Palette.greytext12,
                      ),
                    ],
                  )),
            )),
      ),
    );
  }

  Widget __profilephotoget() {
    return Visibility(
      visible: _imgFilePathphoto != null ? true : false,
      child: Card(
        elevation: 8,
        color: kWhite,
        margin: const EdgeInsets.only(left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [kThemeColorBlue, kThemeColorGreen]),
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(0.9),
              child: Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kWhite, borderRadius: BorderRadius.circular(50)),
                child: _imgFilePathphoto != null &&
                            _imgFileFormatephoto == '.jpg' ||
                        _imgFileFormatephoto == '.png' ||
                        _imgFileFormatephoto == '.jpeg'
                    ? InkWell(
                        onTap: () {
                          getImgFilePathphoto();
                        },
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45)),
                          color: Colors.black12,
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: 140.0,
                            // width: 140.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.file(
                              File(_imgFilePathphoto!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          getImgFilePathphoto();
                        },
                        child: const CircleAvatar(
                          radius: 60,
                          backgroundColor: kWhite,
                          backgroundImage: AssetImage('_logoImg'),
                        ),
                      ),
              ),
            )),
      ),
    );
  }

  Widget get roundedRectBorderWidgetForProfile {
    return DottedBorder(
        borderType: BorderType.RRect,
        //strokeCap: StrokeCap.round,
        dashPattern: const [8, 8],
        strokeWidth: 2,
        radius: const Radius.circular(80),
        padding: const EdgeInsets.all(6),
        color: kThemeColorBlue,
        child:
            // _imgFilePath == null
            //     ?
            InkWell(
          onTap: () {
            getImgFilePathphoto();
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                //color: Colors.amber,
                borderRadius: BorderRadius.circular(60),
                image: const DecorationImage(
                    image: AssetImage('assets/images/addphotosmall.png'))),
          ),
        )
        // // : _imgFilePath == null && _logoImg == null
        // //     ? CircleAvatar(
        // //         radius: 40,
        // //         backgroundColor: Colors.grey[300],
        // //         child: IconButton(
        // //           onPressed: () {
        // //           //  getImgFilePath();
        // //           },
        // //           icon: const Icon(
        // //               Icons.add_circle_outline,
        // //               size: 28),
        // //         ),
        // //       )
        //     : _imgFilePath != null &&
        //     _imgFileFormate == '.jpg' ||
        //     _imgFileFormate == '.png' ||
        //     _imgFileFormate == '.jpeg'
        //     ? InkWell(
        //   onTap: (){
        //     getImgFilePath();
        //
        //   },
        //   child: CircleAvatar(
        //     radius: 40,
        //     // height: 130.0,
        //     // width: 130.0,
        //     // decoration: BoxDecoration(
        //     //   borderRadius: BorderRadius.circular(50),
        //     // ),
        //     //   backgroundImage: CachedNetworkImageProvider(_imgFilePath),
        //     backgroundImage: FileImage(
        //         File(_imgFilePath)),
        //     // child: Image.file(
        //     //   File(_imgFilePath),
        //     //   fit: BoxFit.contain,
        //     // ),
        //   ),
        // )
        //     : InkWell(
        //   onTap: () {},
        //   child: CircleAvatar(
        //     radius: 30.0,
        //     backgroundColor: kWhite,
        //     backgroundImage:
        //     CachedNetworkImageProvider(_logoImg),
        //   ),
        // ),
        // // Container(
        // //   height: 70,
        // //   width: 70,
        // //   decoration: BoxDecoration(
        // //       //color: Colors.amber,
        // //       borderRadius: BorderRadius.circular(60),
        // //       image: DecorationImage(
        // //           image: AssetImage('assets/images/addphotosmall.png'))),
        // // ),
        );
  }

  // void getImgFilePathphoto() async {
  //   try {
  //     String filePathphoto = await FilePicker.getFilePath();
  //     // String filePath = await FilePicker.
  //
  //     if (filePathphoto == '') {
  //       return;
  //     }
  //     print("File path: " + filePathphoto);
  //     setState(() {
  //       _imgFilePathphoto = filePathphoto;
  //
  //       final _extension = p.extension(filePathphoto, 2);
  //       this._imgFileFormatephoto = _extension;
  //
  //       print(':::::::::::::::::$_imgFilePathphoto:::::::::::::::');
  //       print(':::::::::::::::::$_extension:::::::::::::::');
  //
  //       _imgFileNamephoto = filePathphoto.split('/').last;
  //       print(':::::::::::::::::$_imgFileNamephoto:::::::::::::::');
  //
  //       //_uploadImage();
  //     });
  //   } on PlatformException catch (e) {
  //     print("Error while picking the file: " + e.toString());
  //   }
  // }

  void getImgFilePathphoto() async {
    try {
      // String filePath = (await FilePicker.platform) as String;
      // FilePickerResult? filePath = await FilePicker.platform.pickFiles(type: FileType.image);
      var file0 = await FilePicker.platform.pickFiles();
      var file = file0!.files.first.name;
      var filepath = file0.files.first.path;

      if (filepath == '') {
        return;
      }
      print("File path-+++++++++++++++++++++--:  $file");
      print("File path--------------------------:  $filepath");
      _imgFilePathphoto = filepath;
      postValue2 = await dio.MultipartFile.fromFile(
          File(_imgFilePathphoto!).path,
          filename: File(_imgFilePathphoto!).path);
      setState(() {
        _imgFileName = file;

        final extension = p.extension(filepath!, 2);
        _imgFileFormatephoto = extension;

        _imgFileNamephoto = filepath.split('/').last;

        print('===============$_imgFileNamephoto');

        //_uploadImage();
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error while picking the file: $e");
      }
    }
  }

  getShared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('userName');
    fullName = pref.getString('fullName');
    avtarURL = pref.getString('avtarURL');
    coverURL = pref.getString('coverURL');
    setState(() {});
  }
}
