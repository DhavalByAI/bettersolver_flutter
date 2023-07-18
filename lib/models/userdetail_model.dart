class UserDetailModel {
   String? api_status;
   String? api_text;
   String? api_version;
  var user_data;

  UserDetailModel(
      {this.api_status, this.api_text, this.api_version, this.user_data});

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      api_status: json['api_status'],
      api_text: json['api_text'],
      api_version: json['api_version'],
      user_data: json['user_data'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['api_status'] = api_status;
    data['api_text'] = api_text;
    data['api_version'] = api_version;
    data['user_data'] = user_data;
    return data;
  }
}
