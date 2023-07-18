import 'dart:async';

import 'package:bettersolver/models/notification_model.dart';
import 'package:bettersolver/repository/notification_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class NotificationBloc {
  NotificationRepository? _notificationRepository;
  StreamController? _streamController;

  StreamSink get notifcationBlocDataSink => _streamController!.sink;

  Stream get notifcationBlocDataStream => _streamController!.stream;

  NotificationBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Vloc NOTIFICATION');

    _streamController = StreamController();
    _notificationRepository = NotificationRepository();

    fetchNotificationData(_keyLoader, context);
  }

  fetchNotificationData(
      GlobalKey<State> _keyLoader, BuildContext context) async {
    notifcationBlocDataSink.add(Response.loading('Loading'));

    try {
      NotificationModel notificationModel =
          await _notificationRepository!.fetchNotification();

      notifcationBlocDataSink.add(Response.completed(notificationModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
