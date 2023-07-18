class CategoryModel {
   String? apiStatus;

   String? apiText;

   String? apiVersion;

  var group;

  CategoryModel({this.apiStatus, this.apiText, this.apiVersion, this.group});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      group: json['group'],
    );
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> _data = Map<String, dynamic>();

    _data['api_status'] = apiStatus;
    _data['api_text'] = apiText;
    _data['api_version'] = apiVersion;
    _data['group'] = group;

    return _data;
  }
}
