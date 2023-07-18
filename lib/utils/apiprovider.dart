// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:bettersolver/utils/base_constant.dart';
import 'package:bettersolver/utils/customexception.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String _baseUrl = BaseConstant.BASE_URL;

  Future<dynamic> httpMethod(
      String method, String url, var requestBody, String token) async {
    var response;
    try {
      if (method == 'get') {
        response = await http.get(Uri.parse(_baseUrl + url),
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      } else if (method == 'post') {
        response = await http.post(
          Uri.parse(_baseUrl + url),
          body: requestBody,
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        );
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return _response(response);
  }

  Future<dynamic> httpMethodWithoutToken(
      String method, String url, var requestBody) async {
    // ignore: prefer_typing_uninitialized_variables
    var response;
    try {
      if (method == 'get') {
        response = await http.get(Uri.parse(_baseUrl + url));
      } else if (method == 'post') {
        response = await http.post(
          Uri.parse(_baseUrl + url),
          body: requestBody,
        );
      }
    } on SocketException {
      EasyLoading.showError('No Internet connection');
      throw FetchDataException('No Internet connection');
    }
    return _response(response);
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
        break;
      case 400:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
        break;
      case 401:
        var responseJson = json.decode(response.body.toString());
        throw UnauthorisedException(response.body.toString());
        return responseJson;
      case 403:
        var responseJson = json.decode(response.body.toString());
        throw UnauthorisedException(response.body.toString());
        return responseJson;
      case 404:
      case 422:
      case 500:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
        break;
      default:
        var responseJson = json.decode(response.body.toString());
        throw FetchDataException(
            'Error : ${response.statusCode}\n$responseJson');
    }
  }
}
