class BlockedModel {
   String? apiStatus;
   String? apiText;
   String? apiVersion;
  var blocked;

  BlockedModel({this.apiStatus, this.apiText, this.apiVersion, this.blocked});

  factory BlockedModel.fromJson(Map<String, dynamic> json) {
    return BlockedModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      blocked: json['blocked'],
    );
  }

  Map<String, dynamic> tojason() {
    Map<String, dynamic> _data = Map<String, dynamic>();
    _data['api_status'] = apiStatus;
    _data['api_text'] = apiText;
    _data['api_version'] = apiVersion;
    _data['blocked'] = blocked;

    return _data;
  }
}
