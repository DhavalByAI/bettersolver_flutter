import 'dart:developer';
import 'dart:io';
import 'package:bettersolver/screen/ListofPosts.dart';
import 'package:bettersolver/screen/create_post/create_post_controller.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:images_picker/images_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:just_audio/just_audio.dart';

import '../../bottom_navigation.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  var user_id;
  var s;
  ScrollController c = ScrollController();
  var privacyType;
  List privacyList = [
    'Everyone',
    'People I Follow',
    'People Follow Me',
    'Only me',
  ];

  bool isFellingCard = false;
  AudioCl aud = AudioCl(player: AudioPlayer());
  var moodType;

  List moodList = [
    'Feeling',
    'Traveling to',
    'Watching',
    'Playing',
    'Listening to'
  ];

  var feelingType;
  List feelingList = [
    'happy',
    'loved',
    'sad',
    'so_sad',
    'angry',
    'confused',
    'smirk',
    'broke',
    'expressionless',
    'cool',
    'funny',
    'tired',
    'lovely',
    'blessed',
    'shocked',
    'sleepy',
    'pretty',
    'bored'
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CreatePostController _ = Get.put(CreatePostController());
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
            'Create Post',
            style: Palette.greytext20B,
          ),
        ),
        body: SingleChildScrollView(
          controller: c,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(
                height: 20,
              ),
              _titlefield(),
              const SizedBox(
                height: 20,
              ),
              // _captionfield(),
              // const SizedBox(
              //   height: 20,
              // ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: GradientText(
                  'CATEGORY',
                  style: Palette.whiteText12,
                  colors: const [kThemeColorBlue, kThemeColorGreen],
                ),
              ),
              _category(),
              const SizedBox(
                height: 20,
              ),
              _addpost(),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              _fellingCard(),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: GradientText(
                  'PRIVACY',
                  style: Palette.whiteText12,
                  colors: const [kThemeColorBlue, kThemeColorGreen],
                ),
              ),
              _privacy(),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(child: _greyBtn()),
                  Expanded(child: _gradientBtn()),
                ],
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _titlefield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: GradientText(
            'POST TITLE',
            style: Palette.whiteText12,
            colors: const [kThemeColorBlue, kThemeColorGreen],
          ),
        ),
        GetBuilder<CreatePostController>(
          initState: (_) {},
          builder: (_) {
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                maxLength: 25,
                controller: _.titleController,
                onChanged: (value) {
                  _.update();
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Title / Subject",
                  counterText: "${_.titleController.text.length} / 25 ",
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
            );
          },
        ),
      ],
    );
  }

  Widget _category() {
    return GetBuilder<CreatePostController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          child: DropdownButtonFormField(
            // icon: Icon(Icons.add_location),
            style: GoogleFonts.reemKufi(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
            value: _.categoryType,
            hint: Text(
              'Select Category',
              style: GoogleFonts.reemKufi(
                  fontWeight: FontWeight.w400, fontSize: 12),
            ),
            items: _.categoryList.map((item) {
              return DropdownMenuItem(
                value: item['id'],
                child: Text(
                  item['name'],
                  style: Palette.greytext12,
                ),
              );
            }).toList(),
            decoration: const InputDecoration(
              fillColor: kWhite,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding: EdgeInsets.all(5.0),
            ),
            onChanged: (newValue) {
              setState(() {
                print(newValue);
                _.categoryType = newValue;
              });
            },
          ),
        );
      },
    );
  }

  Widget _addpost() {
    return Card(
      elevation: 8,
      color: kWhite,
      margin: const EdgeInsets.only(left: 10, right: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
      child: GetBuilder<CreatePostController>(
        initState: (_) {},
        builder: (_) {
          return Container(
              decoration: Palette.buttonGradient,
              child: Padding(
                padding: const EdgeInsets.all(0.9),
                child: Container(
                    // height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: kWhite, borderRadius: BorderRadius.circular(33)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Flexible(
                          child: GetBuilder<CreatePostController>(
                            initState: (_) {},
                            builder: (_) {
                              return Container(
                                  margin:
                                      const EdgeInsets.only(left: 20, right: 5),
                                  child: TextField(
                                    expands: false,
                                    maxLines: null,
                                    onChanged: (value) {
                                      _.update();
                                    },
                                    controller: _.captionController,
                                    keyboardType: TextInputType.text,
                                    maxLength: 320,
                                    decoration: InputDecoration(
                                      hintText: "What’s better for us?",
                                      hintStyle: Palette.greytext12,
                                      counterText:
                                          "${_.captionController.text.length} / 320  ",

                                      //labelStyle: GoogleFonts.reemKufi(color: Colors.grey),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1),
                                        // borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1),
                                        // borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                        _.file != null && _.audioPath == null
                            ? SizedBox(
                                height: 100,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _.file!.length,
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 12,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return Container(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Stack(
                                              children: [
                                                Image.file(
                                                  File(_
                                                      .file![index].thumbPath!),
                                                ),
                                                SizedBox(
                                                  child: InkWell(
                                                    onTap: () {
                                                      _.file!.removeAt(index);
                                                      _.file!.isEmpty
                                                          ? _.file = null
                                                          : null;

                                                      _.update();
                                                    },
                                                    child: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      },
                                    )),
                              )
                            : _.audioPath != null
                                ? AudioPl()
                                : const SizedBox(),
                        const SizedBox(
                          height: 12,
                        ),
                        _.isPoll
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListView.builder(
                                      controller: c,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(0),
                                      itemBuilder: (context, index) {
                                        return _.extraOptions[index];
                                      },
                                      // separatorBuilder: (context, index) {
                                      //   return const SizedBox();
                                      // },
                                      itemCount: _.extraOptions.isEmpty ||
                                              _.extraOptions == []
                                          ? 0
                                          : _.extraOptions.length),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  _blueBtn(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 15, left: 15, right: 15, top: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: (() async {
                                  final permissionStatus =
                                      await Permission.storage.request();
                                  if (permissionStatus.isDenied) {
                                    print("permission denied will ask");
                                    await Permission.storage.request();
                                    if (permissionStatus.isDenied) {
                                      print("permission denied");
                                      await openAppSettings();
                                    }
                                  } else if (permissionStatus
                                      .isPermanentlyDenied) {
                                    print("permission isPermanentlyDenied");
                                    await openAppSettings();
                                  } else {
                                    print("permission else field");
                                  }

                                  List<Media>? result = await ImagesPicker.pick(
                                    count: 4,
                                    cropOpt: CropOption(),
                                    gif: true,
                                    pickType: PickType.image,
                                  );

                                  // FilePickerResult? result =
                                  //     await FilePicker.platform.pickFiles(
                                  //   type: FileType.image,
                                  //   allowMultiple: true,
                                  //   // allowedExtensions: ['jpg', 'png', 'jpeg'],
                                  // );
                                  if (result != null) {
                                    _.file = result;
                                    _.update();
                                  }
                                  _.audioPath = null;
                                  switch (_.file!.length) {
                                    case 1:
                                      _.multiImage = [
                                        await dio.MultipartFile.fromFile(
                                            File(_.file![0].path).path,
                                            filename:
                                                File(_.file![0].path).path)
                                      ];
                                      break;
                                    case 2:
                                      _.multiImage = [
                                        await dio.MultipartFile.fromFile(
                                            File(_.file![0].path).path,
                                            filename:
                                                File(_.file![0].path).path),
                                        await dio.MultipartFile.fromFile(
                                            File(_.file![1].path).path,
                                            filename:
                                                File(_.file![1].path).path)
                                      ];
                                      break;
                                    case 3:
                                      _.multiImage = [
                                        await dio.MultipartFile.fromFile(
                                            File(_.file![0].path).path,
                                            filename:
                                                File(_.file![0].path).path),
                                        await dio.MultipartFile.fromFile(
                                            File(_.file![1].path).path,
                                            filename:
                                                File(_.file![1].path).path),
                                        await dio.MultipartFile.fromFile(
                                            File(_.file![2].path).path,
                                            filename:
                                                File(_.file![2].path).path)
                                      ];
                                      break;
                                    case 4:
                                      _.multiImage = [
                                        await dio.MultipartFile.fromFile(
                                            File(_.file![0].path).path,
                                            filename:
                                                File(_.file![0].path).path),
                                        await dio.MultipartFile.fromFile(
                                            File(_.file![1].path).path,
                                            filename:
                                                File(_.file![1].path).path),
                                        await dio.MultipartFile.fromFile(
                                            File(_.file![2].path).path,
                                            filename:
                                                File(_.file![2].path).path),
                                        await dio.MultipartFile.fromFile(
                                            File(_.file![3].path).path,
                                            filename:
                                                File(_.file![3].path).path)
                                      ];
                                      break;
                                    default:
                                  }

                                  _.PostKey = "postPhotos[]";
                                  _.postValue = _.multiImage;
                                  _.update();
                                }),
                                child: Image.asset(
                                  'assets/images/photoPost.png',
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final permissionStatus =
                                      await Permission.storage.request();
                                  if (permissionStatus.isDenied) {
                                    print("permission denied will ask");
                                    await Permission.storage.request();
                                    if (permissionStatus.isDenied) {
                                      print("permission denied");
                                      await openAppSettings();
                                    }
                                  } else if (permissionStatus
                                      .isPermanentlyDenied) {
                                    print("permission isPermanentlyDenied");
                                    await openAppSettings();
                                  } else {
                                    print("permission else field");
                                  }

                                  List<Media>? result = await ImagesPicker.pick(
                                    count: 1,
                                    pickType: PickType.video,
                                  );

                                  if (result != null) {
                                    _.file = result;
                                    _.update();
                                  }
                                  _.audioPath = null;
                                  _.PostKey = "postVideo";
                                  _.postValue =
                                      await dio.MultipartFile.fromFile(
                                          File(_.file![0].path).path,
                                          filename: File(_.file![0].path).path);
                                  _.update();
                                },
                                child: Image.asset(
                                  'assets/images/videoPost.png',
                                  height: 25,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await aud.player.stop();
                                  _.isRecording ? await _.stop() : _.start();
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      _.isRecording
                                          ? 'assets/images/recording.png'
                                          : 'assets/images/audioPost.png',
                                      height: 25,
                                    ),
                                    SizedBox(
                                      height: _.isRecording ? 2 : 0,
                                    ),
                                    _.isRecording
                                        ? Text(_.recordDuration.toString())
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isFellingCard = !isFellingCard;
                                    moodType = 'Feeling';
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/emojiPost.png',
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _.isPoll = !_.isPoll;
                                  _.update();
                                },
                                child: Image.asset(
                                  'assets/images/poll.png',
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              Image.asset(
                                'assets/images/locationPost.png',
                                height: 25,
                                width: 25,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ));
        },
      ),
    );
  }

  Widget _blueBtn() {
    return GetBuilder<CreatePostController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          width: MediaQuery.of(context).size.width / 3,
          height: 35,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          // decoration: Palette.buttonGradient,
          decoration: BoxDecoration(
              color: kThemeColorLightBlue,
              borderRadius: BorderRadius.circular(33)),
          child: InkWell(
            onTap: () {
              _.extraOptions.length >= 8
                  ? null
                  : _.extraOptions.add(_option1(_.extraOptions.length));
              _.update();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "ADD OPTION",
                  style: Palette.whiteText15,
                ),
              ),
            ),
          ),
        );
      },
    );
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

  Widget AudioPl() {
    return GetBuilder<CreatePostController>(
      initState: (_) {},
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      aud.isPlaying = !aud.isPlaying;
                      if (aud.firstTime) {
                        aud.duration =
                            await aud.player.setFilePath(_.audioPath!);

                        aud.firstTime = false;
                      }

                      await aud.player.setVolume(1);

                      aud.isPlaying
                          ? await aud.player.play()
                          : await aud.player.pause();
                      setState(() {});
                    },
                    child: StreamBuilder<bool>(
                        stream: aud.player.playingStream,
                        builder: (context, snapshot) {
                          return Icon(
                            snapshot.data ?? false
                                ? Icons.pause
                                : Icons.play_arrow_rounded,
                            size: 30,
                          );
                        }),
                  ),
                  Expanded(
                    child: StreamBuilder<Duration>(
                        stream: aud.player.positionStream,
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            if ((aud.duration != null
                                    ? aud.duration!.inMilliseconds.toDouble()
                                    : 1) ==
                                snapshot.data!.inMilliseconds.toDouble()) {
                              log("finished");
                              aud.firstTime = true;
                              aud.player.stop();
                            }
                          }

                          return Slider(
                            min: 0,
                            max: aud.duration != null
                                ? aud.duration!.inMilliseconds.toDouble()
                                : 0,
                            value: snapshot.data == null
                                ? 0
                                : (aud.duration != null
                                            ? aud.duration!.inMilliseconds
                                                .toDouble()
                                            : 0) <=
                                        snapshot.data!.inMilliseconds.toDouble()
                                    ? 0
                                    : snapshot.data!.inMilliseconds.toDouble(),
                            activeColor: Colors.black,
                            inactiveColor: Colors.black54,
                            onChanged: (value) {
                              // log('${value.toString()}--->${aud.duration!.inMilliseconds.toString()}');
                            },
                          );
                        }),
                  ),
                  InkWell(
                      onTap: () async {
                        aud.curVolume = !aud.curVolume;
                        await aud.player.setVolume(aud.curVolume ? 1 : 0);
                        setState(() {});
                      },
                      child: Icon(aud.curVolume
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded)),
                  const SizedBox(
                    width: 14,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _privacy() {
    return GetBuilder<CreatePostController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          child: DropdownButtonFormField(
            // icon: Icon(Icons.add_location),
            style: GoogleFonts.reemKufi(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
            value: privacyType,
            hint: Text(
              'Everyone',
              style: GoogleFonts.reemKufi(
                  fontWeight: FontWeight.w400, fontSize: 12),
            ),
            items: privacyList.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: Palette.greytext12,
                ),
              );
            }).toList(),
            decoration: const InputDecoration(
              fillColor: kWhite,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding: EdgeInsets.all(5.0),
            ),
            onChanged: (newValue) {
              setState(() {
                privacyType = newValue;
                _.postPrivacy = privacyList.indexOf(newValue);
                print(privacyType);
              });
            },
          ),
        );
      },
    );
  }

  Widget _fellingCard() {
    return Visibility(
        visible: isFellingCard,
        child: Card(
          elevation: 8,
          color: kWhite,
          margin: const EdgeInsets.only(left: 10, right: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
              // decoration: Palette.buttonGradient,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [kThemeColorBlue, kThemeColorGreen]),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(0.9),
                child: Container(
                    //   height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: kWhite, borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: _mooddropdown()),
                              moodType == 'Feeling'
                                  ? Expanded(child: _feelingdropdown())
                                  : Container(),
                            ],
                          ),
                          moodType != 'Feeling'
                              ? _travelingfield()
                              : Container()
                        ],
                      ),
                    )),
              )),
        ));
  }

  Widget _travelingfield() {
    String hinttext = '';

    if (moodType == 'Traveling to') {
      hinttext = 'Where are you Travelling ?';
    } else if (moodType == 'Watching') {
      hinttext = 'What are you watching ?';
    } else if (moodType == 'Playing') {
      hinttext = 'What are you playing ?';
    } else if (moodType == 'Listening to') {
      hinttext = 'what are you Listening to ?';
    }
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: GetBuilder<CreatePostController>(
          initState: (_) {},
          builder: (_) {
            return TextField(
              controller: _.feelingValueController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: hinttext,
                hintStyle: Palette.greytext12,
                //labelStyle: GoogleFonts.reemKufi(color: Colors.grey),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                  // borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                  // borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            );
          },
        ));
  }

  Widget _mooddropdown() {
    return GetBuilder<CreatePostController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          child: DropdownButtonFormField(
            // icon: Icon(Icons.add_location),
            style: GoogleFonts.reemKufi(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
            value: moodType,
            hint: Text(
              'Feeling',
              style: GoogleFonts.reemKufi(
                  fontWeight: FontWeight.w400, fontSize: 12),
            ),
            items: moodList.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: Palette.greytext12,
                ),
              );
            }).toList(),
            decoration: const InputDecoration(
              fillColor: kWhite,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding: EdgeInsets.all(5.0),
            ),
            onChanged: (newValue) {
              setState(() {
                moodType = newValue;
                _.feelingType = newValue.toString();
                _.update();
                print('::::::::');
              });
            },
          ),
        );
      },
    );
  }

  Widget _feelingdropdown() {
    return GetBuilder<CreatePostController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          child: DropdownButtonFormField(
            isDense: true,

            menuMaxHeight: 300,
            // icon: Icon(Icons.add_location),
            style: GoogleFonts.reemKufi(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
            value: feelingType,
            hint: Text(
              'Happy',
              style: GoogleFonts.reemKufi(
                  fontWeight: FontWeight.w400, fontSize: 12),
            ),
            items: feelingList.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: Palette.greytext12,
                ),
              );
            }).toList(),
            decoration: const InputDecoration(
              fillColor: kWhite,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                // borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding: EdgeInsets.all(5.0),
            ),
            onChanged: (newValue) {
              setState(() {
                feelingType = newValue;
                _.feelingValue = newValue.toString();
              });
            },
          ),
        );
      },
    );
  }

  Widget _gradientBtn() {
    return GetBuilder<CreatePostController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: Palette.buttonGradient,
          child: InkWell(
            onTap: () {
              if (_.categoryType != null) {
                if (_.titleController.text.isNotEmpty ||
                    _.titleController.text != "") {
                  _.getAPI();
                  EasyLoading.show(
                      status: 'uploading...',
                      dismissOnTap: false,
                      maskType: EasyLoadingMaskType.black);
                } else {
                  EasyLoading.showToast("Please Enter Title",
                      maskType: EasyLoadingMaskType.black,
                      dismissOnTap: true,
                      duration: const Duration(milliseconds: 2000),
                      toastPosition: EasyLoadingToastPosition.bottom);
                }
              } else {
                EasyLoading.showToast("Please Select Category",
                    maskType: EasyLoadingMaskType.black,
                    dismissOnTap: true,
                    duration: const Duration(milliseconds: 2000),
                    toastPosition: EasyLoadingToastPosition.bottom);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "POST",
                  style: Palette.whiettext18,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _greyBtn() {
    return GetBuilder<CreatePostController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          // decoration: Palette.buttonGradient,
          decoration: BoxDecoration(
              color: kThemeColorGrey, borderRadius: BorderRadius.circular(33)),
          child: InkWell(
            onTap: () {
              _.file = null;
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "CANCEL",
                  style: Palette.whiettext18,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
