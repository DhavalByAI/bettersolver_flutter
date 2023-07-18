import 'dart:async';
import 'package:bettersolver/models/all_post_model.dart';
import 'package:bettersolver/repository/all_post_repository.dart';
import 'package:bettersolver/utils/response.dart';

class AllpostBloc {
  late AllpostRepository _allpostRepository;
  late StreamController _streamController;

  StreamSink get allpostblocDataSink => _streamController.sink;

  Stream get allpostblocDataStream => _streamController.stream;

  AllpostBloc(String pageno, bool firstLoad) {
    print('Call All Post bloc');
    _streamController = StreamController();
    _allpostRepository = AllpostRepository();
    fetchallpostData(pageno, firstLoad);
  }

  fetchallpostData(String pageno, bool firstLoad) async {
    if (firstLoad) {
      allpostblocDataSink.add(Response.loading('Loading...'));
    }
    try {
      AllPostModel allPostModel = await _allpostRepository.fetchallpost(pageno);
      allpostblocDataSink.add(Response.completed(allPostModel));
    } catch (e) {
      allpostblocDataSink.add(Response.error(e.toString()));
      // ErrorDialouge.showErrorDialogue(
      //     context, _keyLoader, "Something went wrong, Contact Admin..!");
      print("Exception === $e");
    }
  }

  dispose() {
    _streamController.close();
  }
}
