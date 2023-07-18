import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bettersolver/bottom_navigation.dart';
import 'package:bettersolver/screen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:google_fonts/google_fonts.dart';
import 'package:images_picker/images_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../style/palette.dart';
import '../../utils/base_constant.dart';

class CreatePostController extends GetxController {
  @override
  void onInit() {
    extraOptions.add(_option1(0));
    extraOptions.add(_option1(1));
    fetchCatList();
    super.onInit();
  }

  List<Media>? file;
  bool isLoading = false;
  List<dynamic>? multiImage;
  String? PostKey;
  var postValue;
  TextEditingController titleController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  TextEditingController feelingValueController = TextEditingController();
  int postPrivacy = 0;
  var categoryType;
  String? feelingType;
  String? feelingValue;
  List categoryList = [];
  bool isRecording = false;
  int recordDuration = 0;
  bool isAudioPlaying = false;
  String? audioPath;
  Timer? _timer;

  bool isPoll = false;
  List extraOptions = [];
  List<TextEditingController> optionController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final FlutterSoundRecord _audioRecorder = FlutterSoundRecord();

  getAPI() async {
    isLoading = true;
    update();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? s = pref.getString('s');
    String? userid = pref.getString('userid');
    String answer = '';
    for (var element in optionController) {
      if (element.text != "") {
        answer = '$answer${element.text},';
      }
    }
    answer = answer.isNotEmpty ? answer.substring(0, answer.length - 1) : "";

    try {
      if (feelingType == 'Traveling to') {
        feelingValue = feelingValueController.text;
        feelingType = 'traveling ';
      } else if (feelingType == 'Watching') {
        feelingValue = feelingValueController.text;
        feelingType = 'watching';
      } else if (feelingType == 'Playing') {
        feelingValue = feelingValueController.text;
        feelingType = 'playing';
      } else if (feelingType == 'Listening to') {
        feelingValue = feelingValueController.text;
        feelingType = 'listening';
      } else if (feelingType == 'Feeling') {
        feelingValue = feelingValueController.text;
        feelingType = 'feelings';
      }
      Map<String, dynamic> params = {
        "user_id": userid,
        "s": s,
        "title": titleController.text.toString(),
        "postText": captionController.text.toString(),
        "postPrivacy": postPrivacy.toString(),
        "group_id": categoryType.toString(),
        PostKey ?? '': postValue,
        'feeling_type': feelingType,
        'feeling': feelingValue,
        'answer': answer,
      };
      print(params);

      dio.Response response = await dio.Dio().post(
        '${BaseConstant.BASE_URL_DEMO}${BaseConstant.BASE_URL_PARAMS}${BaseConstant.newPost}',
        data: dio.FormData.fromMap(params),
      );
      print(response);
      var res = json.decode(response.toString());
      isLoading = false;
      if (res['status'] == "200") {
        EasyLoading.showSuccess("Uploaded Successfully",
            duration: const Duration(milliseconds: 1000),
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true);
        titleController.clear();
        captionController.clear();
        feelingValueController.clear();
        file = null;
        Get.back();
        HomeScreenController _ = Get.find();
        _.fetchallpost("1");
        Get.off(() => const Home());
      } else {
        file = null;
        audioPath = null;
        EasyLoading.showError(res['errors'],
            duration: const Duration(milliseconds: 1000),
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true);
      }
    } catch (e) {
      file = null;
      audioPath = null;
      log(e.toString());
      EasyLoading.showError("Something Went Wrong");
    }
    update();
  }

  fetchCatList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userid');
    var s = pref.getString('s');

    String url =
        '${BaseConstant.BASE_URL}demo2/app_api.php?application=phone&type=get_group';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId,
          's': s,
        },
      );

      var decode = json.decode(response.body);
      print(decode);

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        if (decode['api_status'] == '200') {
          categoryList = decode['group'];
        } else {
          categoryList = [];
        }
      } else {}
    } catch (e) {
      log(e.toString());
      EasyLoading.showError("Something Went Wrong");
    }
    update();
  }

  Future<void> start() async {
    if (await _audioRecorder.hasPermission()) {
      await _audioRecorder.start(
          path: 'storage/emulated/0/Download/recording.wav');
      isRecording = await _audioRecorder.isRecording();
      isRecording = isRecording;
      recordDuration = 0;
      audioPath = null;
      update();
      startTimer();
    }
  }

  Future<void> stop() async {
    _timer?.cancel();
    audioPath = await _audioRecorder.stop();
    print(audioPath);
    isRecording = false;
    PostKey = "postRecord";
    postValue = await dio.MultipartFile.fromFile(File(audioPath!).path,
        filename: File(audioPath!).path);
    update();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      update();
    });
  }

  Widget _option1(int index) {
    return GetBuilder<CreatePostController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _.optionController[index],
                  maxLength: 50,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Option ${index + 1}",
                    // counterText:
                    //     "${_.optionController[index].text.length} / 50",
                    hintStyle: Palette.greytext12,
                    labelStyle: GoogleFonts.reemKufi(color: Colors.grey),
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
              const SizedBox(
                width: 6,
              ),
              index > 1
                  ? InkWell(
                      onTap: () {
                        _.extraOptions.removeLast();
                        var i = 0;
                        for (var element in _.extraOptions) {
                          element = _option1(i++);
                        }
                        _.update();
                      },
                      child: const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.black54,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        );
      },
    );
  }
}
