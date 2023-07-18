class HomeCommentListModel {
   String? apiStatus;
   String? apiText;
   String? apiVersion;
  var post_data;

  HomeCommentListModel({this.apiStatus, this.apiText, this.apiVersion, this.post_data});

  factory HomeCommentListModel.fromJson(Map<String, dynamic> json) {
    return HomeCommentListModel(
        apiStatus: json['api_status'],
        apiText: json['api_text'],
        apiVersion: json['api_version'],
        post_data: json['post_data']);
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> _data = Map<String, dynamic>();
    _data['api_status'] = apiStatus;
    _data['api_text'] = apiText;
    _data['api_version'] = apiVersion;
    _data['post_data'] = post_data;

    return _data;
  }
}