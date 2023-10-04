import 'package:bettersolver/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomEditTextMobile extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CustomEditTextMobile({
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            fillColor: kBlack.withOpacity(0.1),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: kBlack.withOpacity(0.1), width: 2.0),
              borderRadius: BorderRadius.circular(7.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: kBlack.withOpacity(0.1), width: 2.0),
              borderRadius: BorderRadius.circular(7.0),
            ),
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: kBlack.withOpacity(0.1), width: 2.0),
              borderRadius: BorderRadius.circular(7.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: kBlack.withOpacity(0.1), width: 2.0),
              borderRadius: BorderRadius.circular(7.0),
            ),
            contentPadding: const EdgeInsets.all(15.0),
            labelText: label,
            labelStyle: GoogleFonts.roboto(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
