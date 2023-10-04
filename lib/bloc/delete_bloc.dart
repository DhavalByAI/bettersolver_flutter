import 'dart:async';

import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/repository/delete_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class DeleteBloc {
  DeleteRepository? _deleteRepository;
  StreamController? _streamController;

  StreamSink get deleteblocDatasink => _streamController!.sink;

  Stream get deleteblocDataStream => _streamController!.stream;

  DeleteBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Delete Bloc');

    _streamController = StreamController();
    _deleteRepository = DeleteRepository();

    fetchdeleteData(_keyLoader, context);
  }

  fetchdeleteData(GlobalKey<State> keyLoader, BuildContext context) async {
    deleteblocDatasink.add(Response.loading('Loading....'));

    try {
      CommonModel commonModel = await _deleteRepository!.fetchdelete();
      deleteblocDatasink.add(Response.completed(commonModel));
    } catch (e) {
      // Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
