import 'dart:async';
import 'package:bettersolver/models/search_model.dart';
import 'package:bettersolver/repository/search_repository.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:bettersolver/widgets/error_dialouge.dart';
import 'package:flutter/cupertino.dart';

class SearchBLoc {

  SearchRepository? _searchRepository;
  StreamController? _streamController;

  StreamSink get searchblocDataSink =>
      _streamController!.sink;

  Stream get searchblocDataStream =>
      _streamController!.stream;

  SearchBLoc(String searchType,String text,GlobalKey<State> _keyLoader,BuildContext context) {

    print('call Search Bloc ');

    _streamController= StreamController();
    _searchRepository = SearchRepository();
    fetchSearchData(searchType,text,_keyLoader,context);

  }

  fetchSearchData(String searchType,String text,GlobalKey<State> _keyLoader,BuildContext context) async {


    try{

      SearchModel searchModel = await _searchRepository!.fetchSearch(searchType, text);
      searchblocDataSink.add(Response.completed(searchModel));

      String? status = searchModel.apistatus;

      // if(status == '200'){
      //
      //   // ErrorDialouge.showErrorDialogue(
      //   //     context, _keyLoader, "success");
      //
      // }else{
      //   ErrorDialouge.showErrorDialogue(
      //       context, _keyLoader, "Something went wrong, Contact Admin..!");
      // }

    }catch(e){
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(
          context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }

  }
}