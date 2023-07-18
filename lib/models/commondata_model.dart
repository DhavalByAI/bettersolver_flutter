class CommonDataModel {
  var apiStatus;

  String? apiText;

  String? apiVersion;

  var data;

  CommonDataModel({this.apiStatus, this.apiText, this.apiVersion, this.data});

  factory CommonDataModel.fromJson(Map<String, dynamic> json) {
    return CommonDataModel(
        apiStatus: json['api_status'],
        apiText: json['api_text'],
        apiVersion: json['api_version'],
        data: json['data']);
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['api_status'] = apiStatus;
    data['api_text'] = apiText;
    data['api_version'] = apiVersion;
    data['data'] = data;

    return data;
  }
}
