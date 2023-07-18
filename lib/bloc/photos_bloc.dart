import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/photos_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class PhotosBloc {
  PhotosRepositpry? _photosRepositpry;
  StreamController? _streamController;

  StreamSink get photosBlocDataSink =>
      _streamController!.sink;

  Stream get photosBlocDataStream =>
      _streamController!.stream;

  PhotosBloc(String userid, GlobalKey<State> _keyLoader, BuildContext context) {
    print('call photo bloc');

    _streamController = StreamController();
    _photosRepositpry = PhotosRepositpry();

    fetchPhotosData(userid, _keyLoader, context);
  }

  fetchPhotosData(
      String userid, GlobalKey<State> _keyLoader, BuildContext context) async {
    photosBlocDataSink.add(Response.loading('Loading....'));

    try {
      CommonDataModel commonDataModel =
          await _photosRepositpry!.fetchPhoto(userid);
      photosBlocDataSink.add(Response.completed(commonDataModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
