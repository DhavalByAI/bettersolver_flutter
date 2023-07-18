import 'dart:io';

import 'package:bettersolver/screen/setting/seting_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:path/path.dart' as p;

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  TextEditingController detailController = TextEditingController();

  String? _imgFilePath;
  String? _imgFileName;
  String? _imgFileFormate;
  String? _logoImg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        title: Text(
          'FEEDBACK',
          style: Palette.greytext20B,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
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
        child: Column(
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
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Help us improve the better solver feedback is a gift !',
                style: Palette.themText18,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            _detailTextField(),
            const SizedBox(
              height: 40,
            ),
            _screenshots(),
            _screenshotsget(),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'let us know if you have ideas/ suggestions that can help make our product and services better',
                style: Palette.greytext12,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: GradientText(
            'DETAILS',
            style: Palette.whiteText10,
            colors: const [kThemeColorBlue, kThemeColorGreen],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: detailController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Please include as much information as possible",
              hintStyle: Palette.greytext12,

              // labelText: "Email",
              hintMaxLines: 2,
              labelStyle: GoogleFonts.reemKufi(color: const Color(0xFF424242)),
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

  Widget _screenshots() {
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
                        'add a screenshot (recommended)',
                        style: Palette.greytext12,
                      ),
                    ],
                  )),
            )),
      ),
    );
  }

  Widget _screenshotsget() {
    return Visibility(
      visible: _imgFilePath != null ? true : false,
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

      if (filepath == '') {
        return;
      }
      print("File path-+++++++++++++++++++++--:  $file");
      print("File path--------------------------:  $filepath");
      setState(() {
        _imgFilePath = filepath;
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
}
