// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';


// final dio = Dio();
// Future<dynamic> fetchApi(
//     {required String url,
//     bool? get,
//     Object? params,
//     Function()? onSucess,
//     bool errorLogShow = false}) async {
//   // try {
//   EasyLoading.show();
//   log("API Calling ${AppC + url} --> ${params.toString()}");

//   var response = get == null
//       ? await dio.post(
//           AppConst.baseUrl + url,
//           data: params,
//         )
//       : await dio.get(
//           AppConst.baseUrl + url,
//         );
//   if (kDebugMode) {
//     print(response.data.toString());
//   }
//   if (response.statusCode == 200) {
//     if (response.data['status'].toString() == 'true' ||
//         response.data['status'].toString() == 'success') {
//       log("Got Data Successfully");

//       EasyLoading.dismiss();
//       onSucess != null ? onSucess() : null;
//       return response.data;
//     } else {
//       EasyLoading.showError(response.data['msg']);
//       return null;
//     }
//   } else {
//     EasyLoading.showError("Didn't Get Data From API");
//     if (kDebugMode) {
//       print(response.data.toString());
//     }
//     log(response.toString());
//     return null;
//   }

//   // } catch (e) {
//   //   EasyLoading.dismiss();
//   //   ErrorLogShow ? EasyLoading.showError(e.toString()) : null;
//   //   ErrorLogShow ? log(e.toString()) : null;
//   // }
// }
