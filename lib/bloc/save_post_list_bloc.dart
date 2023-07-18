import 'dart:async';

import 'package:bettersolver/models/save_post_list_model.dart';
import 'package:bettersolver/repository/save_post_list_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class SavePostListBloc {
  SavePostListRepository? _savePostListRepository;
  StreamController? _streamController;

  StreamSink get savepostlistBlocDataSink =>
      _streamController!.sink;

  Stream get savepostlistBlocDataStream =>
      _streamController!.stream;

  SavePostListBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('CAll SAVE post List Bloc ');

    _streamController = StreamController();
    _savePostListRepository = SavePostListRepository();

    fetchsavepostlistData(_keyLoader, context);
  }

  fetchsavepostlistData(
      GlobalKey<State> _keyLoader, BuildContext context) async {
    savepostlistBlocDataSink.add(Response.loading('Loading....'));
    try {
      SavePostListModel savePostListModel =
          await _savePostListRepository!.fetchsavepostlist();
      savepostlistBlocDataSink.add(Response.completed(savePostListModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
