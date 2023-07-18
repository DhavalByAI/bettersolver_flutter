class CategoryDetailsModel {
   String? apiStatus;

   String? apiText;

   String? apiVersion;

  var categoryDetailData;

  CategoryDetailsModel(
      {this.apiStatus, this.apiText, this.apiVersion, this.categoryDetailData});

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    return CategoryDetailsModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      categoryDetailData: json['group_data'],
    );
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> _data = Map<String, dynamic>();

    _data['api_status'] = apiStatus;
    _data['api_text'] = apiText;
    _data['api_version'] = apiVersion;
    _data['group_data'] = categoryDetailData;

    return _data;
  }
}
