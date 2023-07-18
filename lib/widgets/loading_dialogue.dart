import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// class LoadingDialog {
//   static Future<void> showLoadingDialog(
//       BuildContext context, GlobalKey key) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () async => false,
//           child: SimpleDialog(
//             key: key,
//             //backgroundColor: Colors.white,
//             shape: Palette.cardShape,
//             children: <Widget>[
//               Container(
//                 height: 60.0,
//                 width: 20.0,
//                 child: const Center(
//                   child: CircularProgressIndicator(
//                     strokeWidth: 3.0,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

class LoadingDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return EasyLoading.show();
  }
}
