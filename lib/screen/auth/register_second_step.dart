import 'dart:convert';

import 'package:bettersolver/bloc/signup_steptwo_bloc.dart';
import 'package:bettersolver/screen/auth/register_thired_step.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:bettersolver/widgets/loading_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterSecondScreen extends StatefulWidget {
  String? email, fname, date;

  RegisterSecondScreen({this.email, this.fname, this.date});

  @override
  State<RegisterSecondScreen> createState() => _RegisterSecondScreenState();
}

class _RegisterSecondScreenState extends State<RegisterSecondScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? formattedDob;

  String? countryType;
  List countryList = [];

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
    NameController.text = widget.fname!;
    emailController.text = widget.email!;
    formattedDob = widget.date;
    print('---------------------${widget.fname}');
    print('---------------------${widget.email}');
    print('---------------------$formattedDob');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 230,
              decoration: Palette.loginGradient,
              child: Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/bettersolver_logo.png'))),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              // decoration: BoxDecoration(
                              //     color: kWhite,
                              //     borderRadius: BorderRadius.circular(33)
                              // ),
                              child: Center(
                                  child: Text(
                                '1',
                                style: Palette.whiteText15,
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
                    style: GoogleFonts.roboto(color: kThemeColorBlue),
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
                    style: GoogleFonts.roboto(color: kThemeColorGreen),
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
            SizedBox(
              height: 20,
            ),
            _userNameEditText(userNameController, 'User Name'),
            _nameEditText(NameController, 'Name'),
            _emailEditText(emailController, 'Email Address'),
            _occupationEditText(occupationController, 'Occupation'),
            _chooseFieldType(),
            _calenderDobDate(),
            SizedBox(
              height: 10,
            ),
            _gradientBtn(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _userNameEditText(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient:
              LinearGradient(colors: [kThemeColorBlue, kThemeColorGreen])),
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            prefixIcon: Icon(Icons.person),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(15.0),
            hintText: label,
            labelStyle: GoogleFonts.roboto(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _nameEditText(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient:
              LinearGradient(colors: [kThemeColorBlue, kThemeColorGreen])),
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          enabled: false,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            prefixIcon: Icon(Icons.person),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(15.0),
            //  hintText: label,
            labelStyle: GoogleFonts.roboto(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _emailEditText(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient:
              LinearGradient(colors: [kThemeColorBlue, kThemeColorGreen])),
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          enabled: false,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            prefixIcon: Icon(Icons.email),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(15.0),
            //  hintText: label,
            labelStyle: GoogleFonts.roboto(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _occupationEditText(TextEditingController controller, String label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient:
              LinearGradient(colors: [kThemeColorBlue, kThemeColorGreen])),
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            prefixIcon: Icon(Icons.business_center),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(15.0),
            hintText: label,
            labelStyle: GoogleFonts.roboto(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _calenderDobDate() {
    return Container(
      decoration: Palette.buttonGradient,
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Padding(
        padding: EdgeInsets.all(0.8),
        child: GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: kWhite,
                border: Border.all(color: Colors.transparent, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(33.0))),
            // decoration: Palette.buttonGradient,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Icon(Icons.calendar_today,  size: 17.0),
                  Icon(
                    Icons.calendar_today_rounded,
                    color: kGreyone,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      "$formattedDob".split(' ')[0],
                      // selectedDob != null ? "$formattedDob".split(' ')[0] : "DOB",
                      style: GoogleFonts.roboto(
                          color: kDarkThemecolor, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _selectDobDate(BuildContext context)  async {
  //   final DateTime picked =  showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(1900, 1),
  //       lastDate: DateTime.now()) as DateTime;
  //   if (picked != null && picked != selectedDob) {
  //     setState(() {
  //       selectedDob = picked;
  //       formattedDob = DateFormat('dd-MM-yyyy').format(selectedDob);
  //       print('Date of birth :: $formattedDob');
  //     });
  //   }
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2010, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDob = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  Widget _chooseFieldType() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: Palette.buttonGradient,
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: DropdownButtonFormField(
          // icon: Icon(Icons.add_location),
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
          value: countryType,
          hint: Text(
            'Country',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          items: countryList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item['name'],
                style: Palette.greytext15,
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            prefixIcon: Icon(Icons.location_on),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onChanged: (newValue) {
            setState(() {
              countryType = newValue;
              print('countryType-------$countryType');
            });
          },
        ),
      ),
    );
  }

  Widget _gradientBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: Palette.buttonGradient,
      child: InkWell(
        onTap: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();

          var _userid = pref.getString("userid");
          var _sid = pref.getString("s");

          // print('----${NameController.text}');

          if (userNameController.text.length <= 6) {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "username length mini 6");
          } else if (occupationController.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "Please enter your occupation");
          } else if (countryType == null) {
            ErrorDialouge.showErrorDialogue(
                context, _keyLoader, "Please seletc country");
          } else {
            //  LoadingDialog.showLoadingDialog(context, _keyLoader);

            SignupStepTwoBloc(
                'register_settings',
                _userid!,
                _sid!,
                userNameController.text,
                formattedDob!,
                countryType!,
                occupationController.text,
                NameController.text,
                _keyLoader,
                context);
          }

          //
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

  Future<void> readJson() async {
    String response =
        await rootBundle.loadString('assets/jsonfile/newcountry.json');
    var decode = await json.decode(response);
    print(':::::::::::::::$decode');

    countryList = decode['countries'];
  }
}
