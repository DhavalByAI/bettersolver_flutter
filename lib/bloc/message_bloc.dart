import 'dart:async';

import 'package:bettersolver/models/message_model.dart';
import 'package:bettersolver/repository/message_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class MessageBloc {
  MessageRepository? _messageRepository;
  StreamController? _streamController;

  StreamSink get messageblocDataSink =>
      _streamController!.sink;

  Stream get messageblocDataStream =>
      _streamController!.stream;

  MessageBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('call Message List Bloc ');

    _streamController = StreamController();
    _messageRepository = MessageRepository();

    fetchMessageData(_keyLoader, context);
  }

  fetchMessageData(GlobalKey<State> _keyLoader, BuildContext context) async {
    messageblocDataSink.add(Response.loading('Loading...'));

    try {
      MessageModel messageModel = await _messageRepository!.fetchMEssage();
      messageblocDataSink.add(Response.completed(messageModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
