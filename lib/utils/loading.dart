import 'package:bettersolver/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loading extends StatelessWidget {
  String? loadingMessage;

  Loading({Key? key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Container(
  //           child: Center(
  //             child: CircularProgressIndicator(backgroundColor: Colors.white),
  //           ),
  //         ),
  //         SizedBox(height: 20.0),
  //         Text(
  //           loadingMessage!,
  //           textAlign: TextAlign.center,
  //           style: Palette.whiteText15,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

// Loading({String? loadingMessage}) {
//   EasyLoading.show();
// }
