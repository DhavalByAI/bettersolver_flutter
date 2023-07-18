import 'dart:async';

import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/video_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class VideoBloc {
  VideoRepository? _videoRepository;
  StreamController? _streamController;

  StreamSink get videoblocDataSink =>
      _streamController!.sink;

  Stream get videoblocDataStream =>
      _streamController!.stream;

  VideoBloc(String userid, GlobalKey<State> _keyLoader, BuildContext context) {
    print('call Video bloc');

    _streamController = StreamController();
    _videoRepository = VideoRepository();

    fetchVideoData(userid, _keyLoader, context);
  }

  fetchVideoData(
      String userid, GlobalKey<State> _keyLoader, BuildContext context) async {
    videoblocDataSink.add(Response.loading('Loading...'));

    try {
      CommonDataModel commonDataModel =
          await _videoRepository!.fetchVideo(userid);
      videoblocDataSink.add(Response.completed(commonDataModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
