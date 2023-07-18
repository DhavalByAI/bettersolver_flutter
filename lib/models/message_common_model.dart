class MessageCommonModel {
   String? apiStatus;
   String? apiText;
   String? apiVersion;
  var messages;

  MessageCommonModel(
      {this.apiStatus, this.apiText, this.apiVersion, this.messages});

  factory MessageCommonModel.fromJson(Map<String, dynamic> json) {
    return MessageCommonModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      messages: json['messages'],
    );
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['api_status'] = apiStatus;
    data['api_text'] = apiText;
    data['api_version'] = apiVersion;
    data['messages'] = messages;
    return data;
  }
}
