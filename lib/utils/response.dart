import 'package:flutter_easyloading/flutter_easyloading.dart';

class Response<T> {
  Status? status;
  T? data;
  String? message;

  Response.loading(this.message) {
    EasyLoading.show();
    status = Status.LOADING;
  }

  Response.completed(this.data) {
    EasyLoading.dismiss();
    status = Status.COMPLETED;
  }

  Response.error(this.message) {
    EasyLoading.showError("Something Went Wrong!!");
    status = Status.ERROR;
  }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
