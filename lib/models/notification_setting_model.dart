class NotificationSettingModel {
   String? apiStatus;
   String? apiText;
   String? apiVersion;
  var settings;

  NotificationSettingModel(
      {this.apiStatus, this.apiText, this.apiVersion, this.settings});

  factory NotificationSettingModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      settings: json['settings'],
    );
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> _data = Map<String, dynamic>();
    _data['api_status'] = apiStatus;
    _data['api_text'] = apiText;
    _data['api_version'] = apiVersion;
    _data['settings'] = settings;

    return _data;
  }
}
