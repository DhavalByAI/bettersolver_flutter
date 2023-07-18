import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ErrorDialouge {
  static showErrorDialogue(
      BuildContext? context, GlobalKey? key, String mesasge) async {
    EasyLoading.showError(mesasge);
    // return showDialog<void>(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return WillPopScope(
    //       onWillPop: () async => false,
    //       child: SimpleDialog(
    //         key: key,
    //         //backgroundColor: Colors.white,
    //         children: <Widget>[
    //           Center(
    //             child: Column(
    //               children: [
    //                 SizedBox(height: 10.0),
    //                 Padding(
    //                   padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
    //                   child: Text(
    //                     mesasge,
    //                     style: Palette.greytext15,
    //                     textAlign: TextAlign.center,
    //                   ),
    //                 ),
    //                 SizedBox(height: 12.0),
    //                 Padding(
    //                   padding: kStandardMargin,
    //                   child: Container(
    //                     width: 150,
    //                     height: 40,
    //                     decoration: Palette.buttonGradient,
    //                     child: MaterialButton(
    //                       onPressed: () {
    //                         Navigator.pop(context);
    //                       },
    //                       // shape: Palette.bottomGradient,
    //                       // color: kBlack,
    //                       child: Text('OK', style: Palette.wihtetext14),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
