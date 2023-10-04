import 'package:bettersolver/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomEditText extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CustomEditText({
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16),
        decoration: InputDecoration(
          fillColor: kWhite,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kBlack, width: 2.0),
            borderRadius: BorderRadius.circular(7.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kred, width: 2.0),
            borderRadius: BorderRadius.circular(7.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: kBlack.withOpacity(0.1), width: 2.0),
            borderRadius: BorderRadius.circular(7.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kBlack.withOpacity(0.1), width: 2.0),
            borderRadius: BorderRadius.circular(7.0),
          ),
          contentPadding: const EdgeInsets.all(15.0),
          hintText: label,
          labelStyle: GoogleFonts.roboto(color: Colors.grey),
        ),
      ),
    );
  }
}
