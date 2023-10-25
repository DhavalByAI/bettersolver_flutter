// import 'dart:developer';

// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:bettersolver/style/constants.dart';
// import 'package:bettersolver/style/palette.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AutoText extends StatefulWidget {
//   List<dynamic> countryList;
//   AutoText({super.key, required this.countryList});

//   @override
//   State<AutoText> createState() => _AutoTextState();
// }

// class _AutoTextState extends State<AutoText> {
//   @override
//   Widget build(BuildContext context) {
//     return AutoCompleteTextField<String>(
//       key: GlobalKey(),
//       clearOnSubmit: false,
//       autofocus: false,
//       suggestions:
//           widget.countryList.map((item) => item['name'].toString()).toList(),
//       style: GoogleFonts.roboto(
//         color: Colors.black,
//         fontWeight: FontWeight.w500,
//         fontSize: 16.0,
//       ),
//       // focusNode: FocusNode(),
//       decoration: InputDecoration(
//         fillColor: kWhite,
//         filled: true,
//         prefixIcon: const Icon(Icons.location_on),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.transparent, width: 1),
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.transparent, width: 1),
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         contentPadding: const EdgeInsets.all(10.0),
//       ),
//       itemFilter: (item, query) {
//         log(item.toString());
//         return item.toLowerCase().contains(query.toLowerCase());
//       },
//       itemSorter: (a, b) {
//         return a.compareTo(b);
//       },
//       itemSubmitted: (item) {
//         setState(() {
//           // countryType = item;
//           // print('countryType-------$countryType');
//         });
//       },
//       itemBuilder: (context, item) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             item,
//             style: Palette.greytext15,
//           ),
//         );
//       },
//     );
//   }
// }
