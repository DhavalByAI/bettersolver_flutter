import 'package:bettersolver/screen/auth/login.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Errors extends StatelessWidget {
  String? errorMessage;

  Function? onRetryPressed;

  Errors({this.errorMessage, this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Session Timeout, Please login again..!",
            textAlign: TextAlign.center,
            style: Palette.whiteText15,
          ),
          SizedBox(height: 15),
          MaterialButton(
            color: Colors.white,
            child:
                Text('Retry', style: GoogleFonts.roboto(color: Colors.black)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
                (route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}
