import 'dart:async';

import 'package:bettersolver/models/category_model.dart';
import 'package:bettersolver/repository/category_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class CategoryBloc {
  CategoryRepository? _categoryRepository;
  StreamController? _streamController;

  StreamSink get CategoryBlocDataSink =>
      _streamController!.sink;

  Stream get CategoryBlocDataStream =>
      _streamController!.stream;

  CategoryBloc(GlobalKey<State> _keyLoader, BuildContext context) {
    print('call Bloc Category');

    _streamController = StreamController();
    _categoryRepository = CategoryRepository();

    fetchCategoryData(_keyLoader, context);
  }

  fetchCategoryData(GlobalKey<State> _keyLoader, BuildContext context) async {
    CategoryBlocDataSink.add(Response.loading('Loading......'));

    try {
      
      CategoryModel categoryModel = await _categoryRepository!.fetchcategory();
      CategoryBlocDataSink.add(Response.completed(categoryModel));
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }
}
