import 'dart:async';

import 'package:bettersolver/models/common_data_integer_model.dart';
import 'package:bettersolver/repository/delete_post_repository.dart';
import 'package:bettersolver/repository/delete_post_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DeletePostBloc {
  DeletePostRepository? deletePostRepository;
  StreamController? _streamController;

  StreamSink get deletePostDataSink => _streamController!.sink;

  Stream get deletePostDataStream => _streamController!.stream;

  DeletePostBloc(
      String postId, GlobalKey<State> _keyLoader, BuildContext context,
      {required VoidCallback onSuccess}) {
    print("call==== loginBLOC");
    _streamController = StreamController();
    deletePostRepository = DeletePostRepository();
    fetchLoginData(postId, _keyLoader, context, onSuccess: onSuccess);
  }

  fetchLoginData(
      String postId, GlobalKey<State> _keyLoader, BuildContext context,
      {required VoidCallback onSuccess}) async {
    //loginDataSink.add(Response.loading('Authenticating login'));
    try {
      print("call==== loginBLOC2");

      CommonDataIntegerModel commonData =
          await deletePostRepository!.delete_post(postId);
      deletePostDataSink.add(Response.completed(commonData));
      Navigator.pop(context);

      int? _status = commonData.apiStatus;

      if (_status == 200) {
        onSuccess();
        print('deleted success::::::::::');
        EasyLoading.showSuccess("deleted success");
      } else {
        ErrorDialouge.showErrorDialogue(
            context, _keyLoader, 'Error found, please try again later.');
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
