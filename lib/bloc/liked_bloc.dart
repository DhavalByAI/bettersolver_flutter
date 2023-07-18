import 'dart:async';

import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/repository/liked_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';

class LikedBloc {
  LikedRepository? _likedRepository;
  StreamController? _streamController;

  StreamSink get linkedblocDataSink => _streamController!.sink;

  Stream get linkedblocDataStream => _streamController!.stream;

  LikedBloc(String postid, String reaction, bool isDelete, String url) {
    print('call  Liked Bloc $isDelete');

    _streamController = StreamController();
    _likedRepository = LikedRepository();

    fetchLiked(postid, reaction, isDelete, url);
  }

  fetchLiked(String postid, String reaction, bool isDelete, String url) async {
    linkedblocDataSink.add(Response.loading('Loading...'));

    try {
      CommonModel commonModel =
          await _likedRepository!.fetchLiked(postid, reaction, isDelete, url);
      linkedblocDataSink.add(Response.completed(commonModel));
    } catch (e) {
      // Get.back();
      ErrorDialouge.showErrorDialogue(
          null, null, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
