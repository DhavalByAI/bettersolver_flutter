import 'dart:async';

import 'package:bettersolver/models/category_details_model.dart';
import 'package:bettersolver/repository/category_details_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class CategoryDetailsBloc {
  CategoryDetailsRepository? _categoryDetailsRepository;
  StreamController? _streamController;

  StreamSink get categorydetailsblocDataSink =>
      _streamController!.sink;

  Stream get categorydetailsblocDataStream =>
      _streamController!.stream;

  CategoryDetailsBloc(
      String groupid, GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call Bloc Category Details');

    _streamController = StreamController();
    _categoryDetailsRepository = CategoryDetailsRepository();

    fetchCategoryDetail(groupid, _keyLoader, context);
  }

  fetchCategoryDetail(
      String groupid, GlobalKey<State> _keyLoader, BuildContext context) async {
    categorydetailsblocDataSink.add(Response.loading('Loading......'));

    try {
      CategoryDetailsModel categoryDetailsModel =
          await _categoryDetailsRepository!.fetchcategorydetails(groupid);
      categorydetailsblocDataSink.add(Response.completed(categoryDetailsModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
