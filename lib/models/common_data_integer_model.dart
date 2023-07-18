class CommonDataIntegerModel {
   int? apiStatus;

   String? apiText;

   String? apiVersion;

  var data;

  CommonDataIntegerModel(
      {this.apiStatus, this.apiText, this.apiVersion, this.data});

  factory CommonDataIntegerModel.fromJson(Map<String, dynamic> json) {
    return CommonDataIntegerModel(
        apiStatus: json['api_status'],
        apiText: json['api_text'],
        apiVersion: json['api_version'],
        data: json['data']);
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> _data = Map<String, dynamic>();
    _data['api_status'] = apiStatus;
    _data['api_text'] = apiText;
    _data['api_version'] = apiVersion;
    _data['data'] = data;

    return _data;
  }
}
