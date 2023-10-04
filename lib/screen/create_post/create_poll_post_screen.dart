import 'package:bettersolver/screen/create_post/create_poll_conroller.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CreatePollPostScreen extends StatefulWidget {
  const CreatePollPostScreen({super.key});

  @override
  State<CreatePollPostScreen> createState() => _CreatePollPostScreenState();
}

class _CreatePollPostScreenState extends State<CreatePollPostScreen> {
  final CreatePollController _ = Get.put(CreatePollController());

  var categoryType;

  var privacyType;

  List privacyList = [
    'Everyone',
    'People I Follow',
    'People Follow Me',
    'Only me',
  ];

  @override
  Widget build(BuildContext context) {
    print(_.extraOptions.length);
    ScrollController c = ScrollController();
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: kWhite,
          title: Text(
            'Create Poll',
            style: Palette.greytext20B,
          ),
        ),
        body: GetBuilder<CreatePollController>(
          initState: (_) {},
          builder: (_) {
            return SingleChildScrollView(
              controller: c,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  _titlefield(),
                  const SizedBox(
                    height: 20,
                  ),
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
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: GradientText(
                      'QUESTION',
                      style: Palette.whiteText12,
                      colors: const [kThemeColorBlue, kThemeColorGreen],
                    ),
                  ),
                  _caption(),
                  const SizedBox(
                    height: 20,
                  ),
                  // _option1(),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // _option2(),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  ListView.separated(
                      controller: c,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _.extraOptions[index];
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: _.extraOptions.isEmpty || _.extraOptions == []
                          ? 0
                          : _.extraOptions.length),
                  const SizedBox(
                    height: 20,
                  ),
                  _blueBtn(),
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
                    height: 20,
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget _titlefield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: GradientText(
            'POLL TITLE',
            style: Palette.whiteText12,
            colors: const [kThemeColorBlue, kThemeColorGreen],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: _.titleController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Title / Subject",
              hintStyle: Palette.greytext12,
              labelStyle: GoogleFonts.roboto(color: Colors.grey),
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

  Widget _category() {
    return GetBuilder<CreatePollController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          child: DropdownButtonFormField(
            // icon: Icon(Icons.add_location),
            style: GoogleFonts.roboto(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
            value: _.categoryType,
            hint: Text(
              'Select Category',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
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

  Widget _caption() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: _.captionController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Ask Something",
          hintStyle: Palette.greytext12,
          labelStyle: GoogleFonts.roboto(color: Colors.grey),
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
  }

  // Widget _option2(int index) {
  //   return Container(
  //     margin: const EdgeInsets.only(left: 10, right: 10),
  //     child: TextField(
  //       controller: optionController[index],
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //         hintText: "Option",
  //         hintStyle: Palette.greytext12,
  //         labelStyle: GoogleFonts.roboto(color: Colors.grey),
  //         enabledBorder: const UnderlineInputBorder(
  //           borderSide: BorderSide(color: Colors.grey, width: 1),
  //           // borderRadius: BorderRadius.circular(30.0),
  //         ),
  //         focusedBorder: const UnderlineInputBorder(
  //           borderSide: BorderSide(color: Colors.grey, width: 1),
  //           // borderRadius: BorderRadius.circular(30.0),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _blueBtn() {
    return GetBuilder<CreatePollController>(
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

  Widget _privacy() {
    return GetBuilder<CreatePollController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          child: DropdownButtonFormField(
            // icon: Icon(Icons.add_location),
            style: GoogleFonts.roboto(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
            value: privacyType,
            hint: Text(
              'Everyone',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
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

  Widget _gradientBtn() {
    return GetBuilder<CreatePollController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: Palette.buttonGradient,
          child: InkWell(
            onTap: () {
              _.getAPI();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "PUBLISH",
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      // decoration: Palette.buttonGradient,
      decoration: BoxDecoration(
          color: kThemeColorGrey, borderRadius: BorderRadius.circular(33)),
      child: InkWell(
        onTap: () {
          //Navigator.push(context,
          // MaterialPageRoute(builder: (context) => RegisterSecondScreen()));
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
  }

  Widget _option1(int index) {
    return GetBuilder<CreatePollController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: _.optionController[index],
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Option ${index + 1}",
              hintStyle: Palette.greytext12,
              labelStyle: GoogleFonts.roboto(color: Colors.grey),
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
    );
  }
}
