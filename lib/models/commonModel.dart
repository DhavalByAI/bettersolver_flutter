class CommonModel {
  String? apistatus;
  String? apitext;
  String? apiversion;
  String? messages;
  CommonModel({this.apistatus, this.apitext, this.apiversion, this.messages});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
        apistatus: json['api_status'],
        apitext: json['api_text'],
        apiversion: json['api_version'],
        messages: json['messages'].toString());
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['api_status'] = apistatus;
    data['api_text'] = apitext;
    data['api_text'] = apiversion;
    data['messages'] = "null";
    return data;
  }
}
