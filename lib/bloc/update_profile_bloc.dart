import 'dart:async';

import 'package:bettersolver/models/commonModel.dart';
import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/repository/update_profile_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:bettersolver/widgets/popback_dialouge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UpdateProfileBloc {
  UpdateProfileRepository? _updateProfileRepository;
  StreamController? _streamController;

  StreamSink get updateprofileblocDataSink => _streamController!.sink;

  Stream get updateprofileblocDataStream => _streamController!.stream;

  UpdateProfileBloc(
      String fname,
      String lname,
      String bio,
      String address,
      String occupation,
      String websiteLink,
      String website,
      String otheroccupation,
      GlobalKey<State> keyLoader,
      BuildContext context) {
    print('call  Upate  Profiel Bloc');

    _streamController = StreamController();
    _updateProfileRepository = UpdateProfileRepository();

    fetchupdateprofiledata(fname, lname, bio, address, occupation, websiteLink,
        website, otheroccupation, keyLoader, context);
  }

  fetchupdateprofiledata(
      String fname,
      String lname,
      String bio,
      String address,
      String occupation,
      String websiteLink,
      String website,
      String otheroccupation,
      GlobalKey<State> keyLoader,
      BuildContext context) async {
    try {
      print('---call  Upate  Profiel Bloc');

      CommonModel commondatamodel = await _updateProfileRepository!
          .fetchupdateprofile(fname, lname, bio, address, occupation,
              websiteLink, website, otheroccupation);

      updateprofileblocDataSink.add(Response.completed(commondatamodel));

      String? _text = commondatamodel.apitext;
      String? _status = commondatamodel.apistatus;
      String? _version = commondatamodel.apiversion;

      if (_status!.contains('200')) {
        Navigator.pop(context);
        EasyLoading.showSuccess('Data Successfully Updated');
        // PopBackDialouge.showDialogue(context, keyLoader, 'Data Updated');
      } else {
        ErrorDialouge.showErrorDialogue(
            context, keyLoader, 'Error found, please try again later.');
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
