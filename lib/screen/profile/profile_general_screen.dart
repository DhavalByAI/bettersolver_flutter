import 'dart:convert';

import 'package:bettersolver/bloc/update_general_setting_bloc.dart';
import 'package:bettersolver/bloc/userdetail_bloc.dart';
import 'package:bettersolver/models/userdetail_model.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/error.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfileGeneralScreen extends StatefulWidget {
  const ProfileGeneralScreen({super.key});

  @override
  State<ProfileGeneralScreen> createState() => _ProfileGeneralScreenState();
}

class _ProfileGeneralScreenState extends State<ProfileGeneralScreen> {
  UserDetailBloc? _userDetailBloc;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final GlobalKey<State> _keyLoaderforloder = GlobalKey<State>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  int temp_i = 0;

  String _countryType = '';
  var countryType;
  List countryList = [];

  var occupationType;
  List occupationList = [
    'student ',
    'teacher',
  ];

  String _radioValue = "";

  String type = "";

  String? _Gender;

  DateTime selectedDate = DateTime.now();
  String formattedDob = '';

  String apiDate = '';

  String _image = '';
  String? username;

  final format = DateFormat("yyyy-MM-dd");
  DateTime dateToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userDetailBloc = UserDetailBloc(_keyLoader, context);
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kWhite,
          title: Text(
            'Settings',
            style: Palette.greytext20B,
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                if (_countryType.isEmpty) {
                  _countryType = countryType;
                } else {
                  _countryType;
                }
                //
                // int countryvalue = int.parse(_countryType);
                // print('countryvalue --$countryvalue');

                print('email-${emailController.text}');
                print(' phone -${phoneController.text}');

                print('username  - ${usernameController.text}');
                print('date -${_dateController.text}');
                print('gender -$_radioValue');
                print('counrty- $_countryType');

                LoadingDialog.showLoadingDialog(context, _keyLoaderforloder);
                print(_radioValue);
                UpdateGeneralSettingBloc(
                    emailController.text,
                    phoneController.text,
                    _radioValue,
                    usernameController.text,
                    _dateController.text,
                    _countryType,
                    _keyLoader,
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
                    return Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: Loading(loadingMessage: snapshot.data.message),
                    );
                    break;
                  case Status.COMPLETED:
                    if (temp_i == 0) {
                      print("Got Data");
                      _radioValue = snapshot.data.data.user_data['gender'];
                      temp_i++;
                    }
                    return _detail(snapshot.data.data);
                    break;
                  case Status.ERROR:
                    return Errors(
                      errorMessage: snapshot.data.message,
                      onRetryPressed: () => _userDetailBloc!
                          .fetchUserDetailData(_keyLoader, context),
                    );
                    break;
                }
              }
              return Container();
            }));
  }

  Widget _detail(UserDetailModel userDetailModel) {
    print('date-in-init&&&&&&$formattedDob');
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      _image = userDetailModel.user_data['avatar'];
      username = userDetailModel.user_data['username'];
      usernameController.text = userDetailModel.user_data['username'];
      phoneController.text = userDetailModel.user_data['phone_number'];
      emailController.text = userDetailModel.user_data['email'];
      _dateController.text = userDetailModel.user_data['birthday'];
      String firstName = userDetailModel.user_data['first_name'];
      String lastName = userDetailModel.user_data['last_name'];

      // _Gender= userDetailModel.user_data['gender'];
      countryType = userDetailModel.user_data['country_id'];

      print('Country_id:::::::::::::%%$countryType');
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 270,
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
                        height: 130,
                        width: 130,
                        margin: const EdgeInsets.only(top: 30),
                        decoration: Palette.RoundGradient,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: CachedNetworkImageProvider(_image))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          //alignment: Alignment.bottomCenter,
                          child: Text(
                            '$firstName $lastName',
                            style: Palette.greytext18B,
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          //alignment: Alignment.bottomCenter,
                          child: Text(
                            '@$username',
                            style: Palette.greytext14,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _userAndPhoneField(),
                  const SizedBox(height: 20),
                  _email(),
                  const SizedBox(height: 20),
                  GradientText(
                    'BIRTH DATE',
                    style: Palette.whiteText10,
                    colors: const [kThemeColorBlue, kThemeColorGreen],
                  ),
                  const SizedBox(height: 5),
                  dateWidget(formattedDob),
                  const SizedBox(height: 20),
                  GradientText(
                    'GENDER',
                    style: Palette.whiteText10,
                    colors: const [kThemeColorBlue, kThemeColorGreen],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                            activeColor: kThemeColorBlue,
                            value: "male",
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange),
                        Text('Male', style: Palette.blackText12),
                        const SizedBox(
                          width: 5,
                        ),
                        Radio(
                          activeColor: kThemeColorBlue,
                          value: "female",
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        Text('Female', style: Palette.blackText12),
                        const SizedBox(
                          width: 5,
                        ),
                        Radio(
                            activeColor: kThemeColorBlue,
                            value: "others",
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange),
                        Text('Custom (Them)', style: Palette.blackText12),
                      ],
                    ),
                  ),
                  // SizedBox(height: 10,),
                  GradientText(
                    'COUNTRY',
                    style: Palette.whiteText10,
                    colors: const [kThemeColorBlue, kThemeColorGreen],
                  ),
                  DropdownButtonFormField(
                    isExpanded: true,
                    style: GoogleFonts.reemKufi(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.0,
                    ),
                    value: "99",
                    hint: Text(
                      'Select Country',
                      style: GoogleFonts.reemKufi(
                          fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                    items: countryList.map((item) {
                      // print(item['id']);
                      return DropdownMenuItem(
                        value: item['id'].toString(),
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
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _countryType = newValue.toString();
                        print('new country id ====$_countryType');
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget dateWidget(String fDate) {
    return DateTimeField(
      controller: _dateController,
      format: format,
      //initialValue: DateTime.now(),
      style: GoogleFonts.reemKufi(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          // borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          // borderRadius: BorderRadius.circular(30.0),
        ),
        contentPadding: EdgeInsets.only(top: 15, bottom: 15, left: 5),
        hintText: 'Date of birth',
      ),
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: dateToday,
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: kblue,
                    onPrimary: Colors.white,
                    surface: kblue,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: kWhite,
                ),
                child: child!,
              );
            });
        currentValue = date ?? currentValue;
        return date;
      },
      // onChanged: (value) {
      //   fDate = _dateController.text;
      // },
    );
  }

  Widget _userAndPhoneField() {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              'USERNAME',
              style: Palette.whiteText10,
              colors: const [kThemeColorBlue, kThemeColorGreen],
            ),
            TextField(
              controller: usernameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "User name ",
                // labelText: "Email",
                labelStyle:
                    GoogleFonts.reemKufi(color: const Color(0xFF424242)),
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
        )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              'PHONE',
              style: Palette.whiteText10,
              colors: const [kThemeColorBlue, kThemeColorGreen],
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "phone",
                // labelText: "Email",
                labelStyle:
                    GoogleFonts.reemKufi(color: const Color(0xFF424242)),

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
        ))
      ],
    );
  }

  Widget _email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          'EMAIL',
          style: Palette.whiteText10,
          colors: const [kThemeColorBlue, kThemeColorGreen],
        ),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "EMAIL",
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
      ],
    );
  }

  // Widget _dob() {
  //   return GestureDetector(
  //     onTap: () {
  //       _selectDate(context);
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(left: 10),
  //       width: MediaQuery.of(context).size.width,
  //       decoration: BoxDecoration(
  //         color: kWhite,
  //         border: Border(bottom: BorderSide(color: Colors.grey)),
  //         // borderRadius: BorderRadius.all(Radius.circular(33.0))
  //       ),
  //       // decoration: Palette.buttonGradient,
  //       child: Padding(
  //         padding: EdgeInsets.all(5.0),
  //         child: Row(
  //           children: [
  //             // Icon(Icons.calendar_today_rounded,color: kGreyone,),
  //             // SizedBox(width: 5,),
  //             Text(
  //                 formattedDob,
  //               style: GoogleFonts.reemKufi(
  //                   color: kDarkThemecolor, fontWeight: FontWeight.w400),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2010, 8),
  //       lastDate: DateTime.now());
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //       formattedDob = DateFormat('yyyy-MM-dd').format(selectedDate);
  //       print('dateFromApiAndFrompick:::::::::::::::$formattedDob');
  //     });
  //   }
  // }

  // Widget _gender() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Radio(
  //         activeColor: kThemeColorBlue,
  //         value: "male",
  //         groupValue: _radioValue,
  //         onChanged: _handleRadioValueChange
  //       ),
  //       Text('Male', style: Palette.blackText12),
  //       const SizedBox(
  //         width: 5,
  //       ),
  //       Radio(
  //         activeColor: kThemeColorBlue,
  //         value: "female",
  //         groupValue: _radioValue,
  //         onChanged:_handleRadioValueChange,
  //       ),
  //       Text('Female', style: Palette.blackText12),
  //       const SizedBox(
  //         width: 5,
  //       ),
  //       Radio(
  //         activeColor: kThemeColorBlue,
  //         value: "custom(Them)",
  //         groupValue: _radioValue,
  //         onChanged: _handleRadioValueChange
  //       ),
  //       Text('Custom (Them)', style: Palette.blackText12),
  //     ],
  //   );
  // }

  // Widget _country() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 15, right: 15),
  //     width: MediaQuery.of(context).size.width / 1.5,
  //     child: DropdownButtonFormField(
  //       // icon: Icon(Icons.add_location),
  //       style: GoogleFonts.reemKufi(
  //         color: Colors.grey,
  //         fontWeight: FontWeight.w400,
  //         fontSize: 10.0,
  //       ),
  //       value: countryType,
  //       hint:Text(
  //         'Select Country',
  //         style: GoogleFonts.reemKufi(
  //
  //             fontWeight: FontWeight.w400,
  //             fontSize: 12),
  //       ),
  //       items: countryList.map((item) {
  //         return DropdownMenuItem(
  //           child: Text(item['name'],style: Palette.greytext12,),
  //           value: item['id'].toString(),
  //         );
  //       }).toList(),
  //       decoration: const InputDecoration(
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
  //         contentPadding: EdgeInsets.all(10.0),
  //       ),
  //       onChanged: (newValue) {
  //         setState(() {
  //           _countryType = newValue;
  //           print('-----$countryType');
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _occupation() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 15, right: 15),
  //     child: DropdownButtonFormField(
  //       // icon: Icon(Icons.add_location),
  //       style: GoogleFonts.reemKufi(
  //         color: Colors.black,
  //         fontWeight: FontWeight.w500,
  //         fontSize: 16.0,
  //       ),
  //       value: occupationType,
  //       hint:Text(
  //         'Select Location',
  //         style: GoogleFonts.reemKufi(
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

  void _handleRadioValueChange(value) {
    // if(_Gender == "male" ){
    //   _radioValue = "male";
    // }else if(_Gender == "female"){
    //   _radioValue = "female";
    // }else {
    //   _radioValue = "custom(Them)";
    // }

    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case "male":
          break;
        case "female":
          break;
        case "custom(Them)":
          break;
      }
    });
  }

  Future<void> readJson() async {
    String response =
        await rootBundle.loadString('assets/jsonfile/newcountry.json');
    var decode = await json.decode(response);
    print(':::::::::::::::$decode');

    countryList = decode['countries'];
  }
}
