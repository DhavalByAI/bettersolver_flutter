import 'dart:io';

import 'package:bettersolver/bloc/update_profile_bloc.dart';
import 'package:bettersolver/bloc/update_profile_bloc.dart';
import 'package:bettersolver/bloc/userdetail_bloc.dart';
import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:path/path.dart' as p;

class BioProfile extends StatefulWidget {
  const BioProfile({super.key});

  @override
  State<BioProfile> createState() => _BioProfileState();
}

class _BioProfileState extends State<BioProfile> {
  UserDetailBloc? _userDetailBloc;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController websitenameController = TextEditingController();
  TextEditingController websitelinkController = TextEditingController();
  TextEditingController anyOtheroccupationController = TextEditingController();

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> keyLoader = GlobalKey<State>();

  var countryType;
  List countryList = ['India ', 'China', 'Usa', 'Uk'];
  int temp_i = 0;
  var occupationType;
  List occupationList = [
    'student ',
    'teacher',
  ];

  String? profileimage;
  String? occuption;
  bool other = false;
  String? selectedOccupation = "Professional";
  String _image = '';
  List<String> occupations = [
    "Business owner",
    "Professional",
    "Student",
    "Housewife",
    "Service"
  ];

  // String _imgFilePath;
  // String _imgFileName;
  // String _imgFileFormate;
  // String _logoImg;

  String? username;

  List selectedTimeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _userDetailBloc = UserDetailBloc(_keyLoader, context);
    // shared();
  }

  // UserDetailBloc _userDetailBloc = UserDetailBloc(_keyLoader, context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kWhite,
          title: Text(
            'Setting',
            style: Palette.greytext20B,
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                LoadingDialog.showLoadingDialog(context, _keyLoader);

                UpdateProfileBloc(
                    firstnameController.text,
                    lastnameController.text,
                    bioController.text,
                    locationController.text,
                    other
                        ? anyOtheroccupationController.text
                        : selectedOccupation!,
                    websitelinkController.text,
                    websitenameController.text,
                    anyOtheroccupationController.text,
                    keyLoader,
                    context);
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
        body: StreamBuilder(
            stream: _userDetailBloc!.userdetailblocDataStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(
                      loadingMessage: snapshot.data.message,
                    );
                    break;
                  case Status.COMPLETED:
                    if (temp_i == 0) {
                      selectedOccupation =
                          snapshot.data.data.user_data['occupation'];
                      if (!occupations.contains(selectedOccupation)) {
                        other = true;
                        anyOtheroccupationController.text =
                            selectedOccupation ?? "";
                      }
                      temp_i++;
                    }

                    return _detail(snapshot.data.data);
                    break;
                  case Status.ERROR:
                    return Container(
                      child: const Text(
                        'Error msg',
                      ),
                    );
                    break;
                }
              }
              return Container();
            }));
  }

  Widget _detail(UserDetailModel userDetailModel) {
    // List result = occuption.split(',');
    // print('$result');
    //
    // if(result.contains('Business owner')){
    //   business == true;
    //   print('--$business--');
    //
    // }
    // else if(occuption.contains('Professional')){
    //   professional == true;
    // }else if(occuption.contains('Service')){
    //   service == true;
    // }else if(occuption.contains('Student')){
    //   student == true;
    // }else if(occuption.contains('Housewife')){
    //   housewife == true;
    // }else if(occuption.contains('Any other')){
    //   other == true;
    // }

    //print('$business');

    //
    //  List splitList = [];
    //  final splitNames= occuption.split(',');
    //
    //  for (int i = 0; i <= result.length; i++){
    //    //splitList.add(splitNames[i]);
    //  }
    //
    //  print('----$splitList');
    String selectedOccupation =
        userDetailModel.user_data['occupation'] ?? "Business owner";
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      _image = userDetailModel.user_data['avatar'];

      firstnameController.text = userDetailModel.user_data['first_name'] ?? '-';

      lastnameController.text = userDetailModel.user_data['last_name'] ?? '-';

      username = userDetailModel.user_data['username'] ?? '-';

      bioController.text = userDetailModel.user_data['about'] ?? '-';

      locationController.text = userDetailModel.user_data['address'] ?? '-';
      websitenameController.text = userDetailModel.user_data['website'] ?? '-';
      websitelinkController.text =
          userDetailModel.user_data['working_link'] ?? '-';
      occuption = userDetailModel.user_data['occupation'];

      //
      // firstnameController.text = _fName;
      // lastnameController.text = _lname;

      return SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
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
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    CachedNetworkImageProvider(_image),
                              )

                              // _image != null && _imgFilePath == null
                              //     ? CircleAvatar(
                              //         radius: 40,
                              //         backgroundImage: CachedNetworkImageProvider(_image),
                              //       )
                              //     : _imgFilePath == null && _logoImg == null
                              //         ? CircleAvatar(
                              //             radius: 40,
                              //             backgroundColor: Colors.grey[300],
                              //             child: IconButton(
                              //               onPressed: () {
                              //                 getImgFilePath();
                              //               },
                              //               icon: const Icon(
                              //                   Icons.add_circle_outline,
                              //                   size: 28),
                              //             ),
                              //           )
                              //         : _imgFilePath != null &&
                              //                     _imgFileFormate == '.jpg' ||
                              //                 _imgFileFormate == '.png' ||
                              //                 _imgFileFormate == '.jpeg'
                              //             ? CircleAvatar(
                              //                 radius: 40,
                              //                 // height: 130.0,
                              //                 // width: 130.0,
                              //                 // decoration: BoxDecoration(
                              //                 //   borderRadius: BorderRadius.circular(50),
                              //                 // ),
                              //                 //   backgroundImage: CachedNetworkImageProvider(_imgFilePath),
                              //                 backgroundImage: FileImage(
                              //                     File(_imgFilePath)),
                              //                 // child: Image.file(
                              //                 //   File(_imgFilePath),
                              //                 //   fit: BoxFit.contain,
                              //                 // ),
                              //               )
                              //             : InkWell(
                              //                 onTap: () {},
                              //                 child: CircleAvatar(
                              //                   radius: 30.0,
                              //                   backgroundColor: kWhite,
                              //                   backgroundImage:
                              //                       CachedNetworkImageProvider(_logoImg),
                              //                 ),
                              //               ),

                              )),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Text(
                          '$username',
                          style: Palette.greytext16B,
                        ),
                      )
                    ],
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     getImgFilePath();
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.only(top: 40, left: 110),
                  //     decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //             image:
                  //                 AssetImage('assets/images/editphoto.png'))),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: 30,
                  // ),
                  _firstandlastName(),
                  const SizedBox(
                    height: 20,
                  ),
                  _bio(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: GradientText(
                      'LOCATION',
                      style: Palette.whiteText10,
                      colors: const [kThemeColorBlue, kThemeColorGreen],
                    ),
                  ),
                  _location(),
                  const SizedBox(
                    height: 20,
                  ),
                  _WbsiteNameandLink(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: GradientText(
                      'OCCUPATION',
                      style: Palette.whiteText10,
                      colors: const [kThemeColorBlue, kThemeColorGreen],
                    ),
                  ),
                  //_occupation(),

                  occup(occupations),

                  _chehckBoxRowThird(),
                  Visibility(
                      visible: other == true,
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: TextField(
                          controller: anyOtheroccupationController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter occupation",
                            // labelText: "Email",
                            hintMaxLines: 2,
                            labelStyle: GoogleFonts.roboto(
                                color: const Color(0xFF424242)),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                              // borderRadius: BorderRadius.circular(30.0),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                              // borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Wrap occup(List<String> occupations) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: List.generate(
        occupations.length,
        (index) {
          print(selectedOccupation);
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioMenuButton(
                value: occupations[index],
                groupValue: selectedOccupation,
                onChanged: (value) {
                  setState(() {
                    other = false;
                    print(value);
                    selectedOccupation = value!;
                  });
                  print(selectedOccupation);
                },
                child: Text(
                  occupations[index],
                  style: Palette.greytext14,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _firstandlastName() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                'FIRST NAME',
                style: Palette.whiteText10,
                colors: const [kThemeColorBlue, kThemeColorGreen],
              ),
              TextField(
                controller: firstnameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Enter your first name",
                  // labelText: "Email",
                  hintStyle: GoogleFonts.roboto(color: const Color(0xFF424242)),
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
            ],
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                'LAST NAME',
                style: Palette.whiteText10,
                colors: const [kThemeColorBlue, kThemeColorGreen],
              ),
              TextField(
                controller: lastnameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Enter your last name",
                  // labelText: "Email",
                  labelStyle:
                      GoogleFonts.roboto(color: const Color(0xFF424242)),

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
            ],
          ),
        ))
      ],
    );
  }

  Widget _bio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: GradientText(
            'ENTER BIO',
            style: Palette.whiteText10,
            colors: const [kThemeColorBlue, kThemeColorGreen],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: bioController,
            maxLines: 2,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Enter Bio",
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

  Widget _WbsiteNameandLink() {
    return Row(
      children: [
        // Expanded(
        //     child: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       GradientText(
        //         'WEBSITE',
        //         style: Palette.whiteText10,
        //         colors: [kThemeColorBlue, kThemeColorGreen],
        //       ),
        //       TextField(
        //         controller: websitenameController,
        //         keyboardType: TextInputType.text,
        //         decoration: const InputDecoration(
        //           hintText: "Website name",
        //           // labelText: "Email",
        //           labelStyle: GoogleFonts.roboto(color: Color(0xFF424242)),
        //           enabledBorder: UnderlineInputBorder(
        //             borderSide: BorderSide(color: Colors.grey, width: 1),
        //             // borderRadius: BorderRadius.circular(30.0),
        //           ),
        //           focusedBorder: UnderlineInputBorder(
        //             borderSide: BorderSide(color: Colors.grey, width: 1),
        //             // borderRadius: BorderRadius.circular(30.0),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                'WEBSITE URL',
                style: Palette.whiteText10,
                colors: const [kThemeColorBlue, kThemeColorGreen],
              ),
              TextField(
                controller: websitelinkController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Website link",
                  // labelText: "Email",
                  labelStyle:
                      GoogleFonts.roboto(color: const Color(0xFF424242)),

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
            ],
          ),
        ))
      ],
    );
  }

  Widget _location() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: locationController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Enter Location",
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
    );
  }

  // Widget _occupation() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 15, right: 15),
  //     child: DropdownButtonFormField(
  //       // icon: Icon(Icons.add_location),
  //       style: GoogleFonts.roboto(
  //         color: Colors.black,
  //         fontWeight: FontWeight.w500,
  //         fontSize: 16.0,
  //       ),
  //       value: occupationType,
  //       hint:Text(
  //         'Select Location',
  //         style: GoogleFonts.roboto(
  //
  //             //fontWeight: FontWeight.w400,
  //             fontSize: 12),
  //       ),
  //       items: occupationList.map((item) {
  //         return DropdownMenuItem(
  //           child: Text(
  //             item,
  //             style: Palette.greytext15,
  //           ),
  //           value: item,
  //         );
  //       }).toList(),
  //       decoration: InputDecoration(
  //         fillColor: kWhite,
  //         filled: true,
  //         enabledBorder: UnderlineInputBorder(
  //           borderSide: BorderSide(color: Colors.grey, width: 1),
  //           // borderRadius: BorderRadius.circular(30.0),
  //         ),
  //         focusedBorder: UnderlineInputBorder(
  //           borderSide: BorderSide(color: Colors.grey, width: 1),
  //           // borderRadius: BorderRadius.circular(30.0),
  //         ),
  //         contentPadding: const EdgeInsets.all(10.0),
  //       ),
  //       onChanged: (newValue) {
  //         setState(() {
  //           occupationType = newValue;
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _chehckBoxRowFirst() {
  //   return Row(
  //     children: [
  //       Checkbox(
  //         checkColor: kBlack,
  //         activeColor: kThemeColorBlue,
  //         //fillColor: MaterialStateProperty.resolveWith(getColor),
  //         value: business,
  //         onChanged: (value) {
  //           setState(() {
  //             business = value!;
  //           });
  //         },
  //       ),
  //       Text(
  //         'Business owner',
  //         style: Palette.greytext14,
  //       ),
  //       Checkbox(
  //         checkColor: kBlack,
  //         activeColor: kThemeColorBlue,
  //         //fillColor: MaterialStateProperty.resolveWith(getColor),
  //         value: professional,
  //         onChanged: (value) {
  //           setState(() {
  //             professional = value!;
  //           });
  //         },
  //       ),
  //       Text(
  //         'Professional',
  //         style: Palette.greytext14,
  //       ),
  //       // Checkbox(
  //       //   checkColor: kBlack,
  //       //   activeColor: kThemeColorBlue,
  //       //   //fillColor: MaterialStateProperty.resolveWith(getColor),
  //       //   value: service,
  //       //   onChanged: (value) {
  //       //     setState(() {
  //       //       service = value!;
  //       //     });
  //       //   },
  //       // ),
  //       // Text(
  //       //   'Service',
  //       //   style: Palette.greytext14,
  //       // ),
  //     ],
  //   );
  // }

  Widget _chehckBoxRowThird() {
    return Row(
      children: [
        Checkbox(
          checkColor: kBlack,
          activeColor: kThemeColorBlue,
          //fillColor: MaterialStateProperty.resolveWith(getColor),
          value: other,
          onChanged: (value) {
            setState(() {
              selectedOccupation = "Any other";
              other = value!;
            });
          },
        ),
        Text(
          'Any other',
          style: Palette.greytext14,
        ),
        // Checkbox(
        //   checkColor: kBlack,
        //   activeColor: kThemeColorBlue,
        //   //fillColor: MaterialStateProperty.resolveWith(getColor),
        //   value: service,
        //   onChanged: (value) {
        //     setState(() {
        //       service = value!;
        //     });
        //   },
        // ),
        // Text(
        //   'Service',
        //   style: Palette.greytext14,
        // ),
      ],
    );
  }

  // Widget _chehckBoxRowSecond() {
  //   return Row(
  //     children: [
  //       Checkbox(
  //         checkColor: kBlack,
  //         activeColor: kThemeColorBlue,
  //         //fillColor: MaterialStateProperty.resolveWith(getColor),
  //         value: student,
  //         onChanged: (value) {
  //           setState(() {
  //             student = value!;
  //           });
  //         },
  //       ),
  //       Text(
  //         'Student',
  //         style: Palette.greytext14,
  //       ),
  //       Checkbox(
  //         checkColor: kBlack,
  //         activeColor: kThemeColorBlue,
  //         //fillColor: MaterialStateProperty.resolveWith(getColor),
  //         value: housewife,
  //         onChanged: (value) {
  //           setState(() {
  //             housewife = value!;
  //           });
  //         },
  //       ),
  //       Text(
  //         'Housewife',
  //         style: Palette.greytext14,
  //       ),
  //       Checkbox(
  //         checkColor: kBlack,
  //         activeColor: kThemeColorBlue,
  //         //fillColor: MaterialStateProperty.resolveWith(getColor),
  //         value: service,
  //         onChanged: (value) {
  //           setState(() {
  //             service = value!;
  //           });
  //         },
  //       ),
  //       Text(
  //         'Service',
  //         style: Palette.greytext14,
  //       ),
  //       // Checkbox(
  //       //   checkColor: kBlack,
  //       //   activeColor: kThemeColorBlue,
  //       //   //fillColor: MaterialStateProperty.resolveWith(getColor),
  //       //   value: other,
  //       //   onChanged: (value) {
  //       //     setState(() {
  //       //       other = value!;
  //       //     });
  //       //   },
  //       // ),
  //       // Text(
  //       //   'Any other',
  //       //   style: Palette.greytext14,
  //       // ),
  //     ],
  //   );
  // }

  //
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

  shared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      String? s = pref.getString('s');
      String? userid = pref.getString('userid');
      _userDetailBloc = UserDetailBloc(_keyLoader, context);
    });
  }
}
