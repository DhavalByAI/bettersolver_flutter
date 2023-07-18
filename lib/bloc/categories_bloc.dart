import 'dart:async';

import 'package:bettersolver/models/categories_model.dart';
import 'package:bettersolver/repository/categories_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class CategoriesBloc {
  CategoriesRepository? _categoriesRepository;
  StreamController? _streamController;

  StreamSink get categoriesBlocDataSink =>
      _streamController!.sink;

  Stream get categoriesBlocDataStream =>
      _streamController!.stream;

  CategoriesBloc(
      String userid, GlobalKey<State> _keyLoader, BuildContext context) {
    print('Call categories bloc');

    _streamController = StreamController();
    _categoriesRepository = CategoriesRepository();

    fetchCategoriesData(userid, _keyLoader, context);
  }

  fetchCategoriesData(
      String _userId, GlobalKey<State> _keyLoader, BuildContext context) async {
    categoriesBlocDataSink.add(Response.loading('Loading..'));

    try {
      CategoriesModel categoriesModel =
          await _categoriesRepository!.fetchCategories(_userId);
      categoriesBlocDataSink.add(Response.completed(categoriesModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
