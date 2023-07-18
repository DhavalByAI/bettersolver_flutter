class CommonMessageModel {
   String? apiStatus;

   String? apiText;

   String? apiVersion;

  var message;

  CommonMessageModel(
      {this.apiStatus, this.apiText, this.apiVersion, this.message});

  factory CommonMessageModel.fromJson(Map<String, dynamic> json) {
    return CommonMessageModel(
        apiStatus: json['api_status'],
        apiText: json['api_text'],
        apiVersion: json['api_version'],
        message: json['message']);
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['api_status'] = apiStatus;
    data['api_text'] = apiText;
    data['api_version'] = apiVersion;
    data['message'] = message;

    return data;
  }
}
