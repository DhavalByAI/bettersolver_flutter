class MyActivitesModel {
   String? apiStatus;
   String? apiText;
   String? apiVersion;
  var activities;

  MyActivitesModel(
      {this.apiStatus, this.apiText, this.apiVersion, this.activities});

  factory MyActivitesModel.fromJson(Map<String, dynamic> json) {
    return MyActivitesModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      activities: json['activities'],
    );
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['api_status'] = apiStatus;
    data['api_text'] = apiText;
    data['api_version'] = apiVersion;
    data['activities'] = activities;

    return data;
  }
}
