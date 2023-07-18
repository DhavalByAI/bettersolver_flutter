class CategoriesModel {
   String? apiStatus;

   String? apiText;

   String? apiVersion;

  var categoreiesData;

  CategoriesModel(
      {this.apiStatus, this.apiText, this.apiVersion, this.categoreiesData});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      categoreiesData: json['mygroups'],
    );
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> _data = Map<String, dynamic>();

    _data['api_status'] = apiStatus;
    _data['api_text'] = apiText;
    _data['api_version'] = apiVersion;
    _data['mygroups'] = categoreiesData;

    return _data;
  }
}
