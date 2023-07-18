class PrivacyGetModel {
   String? apiStatus;
   String? apiText;
   String? apiVersion;
  var privacydata;

  PrivacyGetModel(
      {this.apiStatus, this.apiText, this.apiVersion, this.privacydata});

  factory PrivacyGetModel.fromJson(Map<String, dynamic> json) {
    return PrivacyGetModel(
        apiStatus: json['api_status'],
        apiText: json['api_text'],
        apiVersion: json['api_version'],
        privacydata: json['privacy_data']);
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['api_status'] = apiStatus;
    data['api_text'] = apiText;
    data['api_version'] = apiVersion;
    data['privacy_data'] = privacydata;

    return data;
  }
}
