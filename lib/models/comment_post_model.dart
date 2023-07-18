class CommentPostModel {
  int? status;
  int? apiStatus;
  String? apiText;
  String? apiVersion;
  String? comments_num;
  var messages;

  int? can_send;

  CommentPostModel(
      {this.status,
      this.apiStatus,
      this.apiText,
      this.apiVersion,
      this.comments_num,
      this.messages,
      this.can_send});

  factory CommentPostModel.fromJson(Map<String, dynamic> json) {
    return CommentPostModel(
      status: json['status'],
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      comments_num: json['comments_num'],
      messages: json['messages'],
      can_send: json['can_send'],
    );
  }

  Map<String, dynamic> tojason() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['api_status'] = apiStatus;
    data['api_text'] = apiText;
    data['api_version'] = apiVersion;
    data['comments_num'] = comments_num;
    data['messages'] = messages;
    data['can_send'] = can_send;

    return data;
  }
}
