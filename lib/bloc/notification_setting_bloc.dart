import 'dart:async';

import 'package:bettersolver/models/notification_model.dart';
import 'package:bettersolver/models/notification_setting_model.dart';
import 'package:bettersolver/repository/notification_setting_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class NotificationSettingBloc {
  NotificationSettingRepository? _notificationSettingRepository;
  StreamController? _streamController;

  StreamSink
      get notificationsettingblocDataSink => _streamController!.sink;

  Stream
      get notificationsettingblocDataStream => _streamController!.stream;

  NotificationSettingBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Notification setting bloc');

    _streamController = StreamController();
    _notificationSettingRepository = NotificationSettingRepository();

    fetchNotificationSettingData(_keyLoader, context);
  }

  fetchNotificationSettingData(
      GlobalKey<State> _keyLoader, BuildContext context) async {
    notificationsettingblocDataSink.add(Response.loading('Loading...'));

    try {
      NotificationSettingModel notificationSettingModel =
          await _notificationSettingRepository!.fetchnotificationsetting();
      notificationsettingblocDataSink
          .add(Response.completed(notificationSettingModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
