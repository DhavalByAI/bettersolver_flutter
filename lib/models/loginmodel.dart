class LoginModel {
  String? apiStatus;
  String? apiText;
  String? apiVersion;
  String? userId;
  String? profileImage;
  var errors;
  var messages;

  LoginModel(
      {this.apiStatus,
      this.apiText,
      this.apiVersion,
      this.userId,
      this.profileImage,
      this.errors,
      this.messages});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      userId: json['user_id'],
      profileImage: json['profile_image'],
      messages: json['messages'],
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['api_status'] = apiStatus;
    data['api_text'] = apiText;
    data['api_version'] = apiVersion;
    data['user_id'] = userId;
    data['profile_image'] = profileImage;
    data['messages'] = messages;
    data['errors'] = errors;
    return data;
  }
}
