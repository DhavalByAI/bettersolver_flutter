import 'dart:io';
import 'dart:convert';
import 'package:bettersolver/screen/auth/register_second_step.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/base_constant.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterFirstScreen extends StatefulWidget {
  String? email, fname, date;

  RegisterFirstScreen({super.key, this.email, this.fname, this.date});

  @override
  State<RegisterFirstScreen> createState() => _RegisterFirstScreenState();
}

class _RegisterFirstScreenState extends State<RegisterFirstScreen> {
  final String _image = '';

  String? _imgFilePath;
  String? _imgFileName;
  String? _imgFileFormate;
  String? _logoImg;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyError = GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('---------------------${widget.fname}');
    print('---------------------${widget.email}');
    print('---------------------${widget.date}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 230,
              decoration: Palette.loginGradient,
              child: Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/bettersolver_logo.png'))),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    elevation: 8,
                    color: kWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33)),
                    child: Container(
                        decoration: Palette.buttonGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(0.9),
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(33)),
                              child: Center(
                                  child: Text(
                                '1',
                                style: Palette.themText15,
                              ))),
                        )
                        //Card(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(50)),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(top: 10,bottom: 10,left: 12,right: 12),
                        //       child: Text('1',style: Palette.themText15,)
                        //     ),
                        //   ),

                        ),
                  ),
                  // Container(
                  //     margin: EdgeInsets.only(left: 1,right: 1),
                  //     child: const DottedLine()),
                  Text(
                    '- - - - - - - - - - - - -',
                    style: GoogleFonts.reemKufi(color: kThemeColorBlue),
                  ),
                  Card(
                    elevation: 8,
                    color: kWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33)),
                    child: Container(
                        decoration: Palette.buttonGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(0.9),
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(33)),
                              child: Center(
                                  child: Text(
                                '2',
                                style: Palette.themText15,
                              ))),
                        )
                        //Card(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(50)),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(top: 10,bottom: 10,left: 12,right: 12),
                        //       child: Text('1',style: Palette.themText15,)
                        //     ),
                        //   ),

                        ),
                  ),
                  Text(
                    '- - - - - - - - - - - - -',
                    style: GoogleFonts.reemKufi(color: kThemeColorGreen),
                  ),
                  Card(
                    elevation: 8,
                    color: kWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33)),
                    child: Container(
                        decoration: Palette.buttonGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(0.9),
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(33)),
                              child: Center(
                                  child: Text(
                                '3',
                                style: Palette.themText15,
                              ))),
                        )
                        //Card(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(50)),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(top: 10,bottom: 10,left: 12,right: 12),
                        //       child: Text('1',style: Palette.themText15,)
                        //     ),
                        //   ),

                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              elevation: 8,
              color: kWhite,
              margin: const EdgeInsets.only(left: 40, right: 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33)),
              child: Container(
                  decoration: Palette.buttonGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(0.9),
                    child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(33)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'ADD PHOTO',
                              style: Palette.blackText30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Show your unique personality and style.',
                              style: Palette.blackText11,
                            ),
                            const SizedBox(height: 30),
                            roundedRectBorderWidget
                          ],
                        )),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            _gradientBtn()
          ],
        ),
      ),
    );
  }

  Widget get roundedRectBorderWidget {
    return DottedBorder(
      borderType: BorderType.RRect,
      //strokeCap: StrokeCap.round,
      dashPattern: const [8, 8],
      strokeWidth: 2,
      radius: const Radius.circular(80),
      padding: const EdgeInsets.all(6),
      color: kThemeColorBlue,
      child: _imgFilePath == null && _logoImg == null
          ? InkWell(
              onTap: () {
                getImgFilePath();
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                // backgroundImage: AssetImage('assets/images/addphoto.png'),
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/addphoto.png'))),
                ),
              ),
            )
          : _imgFilePath != null && _imgFileFormate == '.jpg' ||
                  _imgFileFormate == '.png' ||
                  _imgFileFormate == '.jpeg'
              ? InkWell(
                  onTap: () {
                    getImgFilePath();
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70)),
                    color: Colors.black12,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      height: 130.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.file(
                        File(_imgFilePath!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    getImgFilePath();
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: kWhite,
                    backgroundImage: CachedNetworkImageProvider(_logoImg!),
                  ),
                ),
    );
  }

  // void getImgFilePath() async {
  //   try {
  //     var filePath = await FilePicker.platform.pickFiles();
  //     // String filePath = await FilePicker.
  //
  //     if (filePath == '') {
  //       return;
  //     }
  //     print("File path: " + filePath!);
  //     setState(() {
  //       _imgFilePath = filePath as String?;
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

  Widget _gradientBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: Palette.buttonGradient,
      child: InkWell(
        onTap: () {
          print('file path------$_imgFilePath');
          _addphotoApi();
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => RegisterSecondScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "SAVE & CONTINUE",
              style: Palette.whiettext18,
            ),
          ),
        ),
      ),
    );
  }

  //
  // final requestBody ={
  //   'profile':profilephoto,
  //   'user_id':userid,
  //   's':s,
  // };
  //
  //
  // final respones = await _provider.httpMethodWithoutToken('post', 'demo2/app_api.php?application=phone&type=display', requestBody);

  Future<void> _addphotoApi() async {
    // LoadingDialog.showLoadingDialog(context, _keyLoader);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userid = pref.getString("userid");
    var sid = pref.getString("s");

    print('seesion id $sid');
    print('_userid $userid');

    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(
            '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=display'),
      );
      // request.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      request.fields['user_id'] = userid!;
      request.fields['s'] = sid!;

      if (_imgFilePath == null) {
        _imgFilePath = null;
      } else {
        var logoImage =
            await http.MultipartFile.fromPath("profile", _imgFilePath!);
        request.files.add(logoImage);
      }

      // var logoImage =
      // await http.MultipartFile.fromPath("photo1", _imgFilePath);
      // request.files.add(logoImage);

      var response = await request.send();
      print('response $response');

      response.stream.transform(utf8.decoder).listen(
        (value) {
          print(value);
          Map<String, dynamic> decode = json.decode(value);
          String statustext = decode['api_text'];
          var data = decode['data'];
          var profileImage = data['avatar'];

          //set response
          if (statustext.contains('success')) {
            pref.setString('profilephoto', profileImage);
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterSecondScreen(
            //   date: widget.date,
            //   email: widget.email,
            //   fname: widget.fname,
            // )));

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => RegisterSecondScreen(
                  date: widget.date!,
                  email: widget.email!,
                  fname: widget.fname!,
                ),
              ),
            );
          } else {
            //  Navigator.pop(context);
            ErrorDialouge.showErrorDialogue(context, _keyError,
                'Something went wrong, Please try again..!');
          }
        },
      );
    } catch (e) {
      // Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(context, _keyError, e.toString());
      print("Exeption $e");
    }
  }
}
