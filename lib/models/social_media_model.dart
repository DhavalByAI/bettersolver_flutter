class SocialMediaModel {
  String? apiStatus;
  String? apiText;
  String? apiVersion;
  String? user_id;
  String? messages;
  String? timezone;
  String? cookie;

  SocialMediaModel(
      {this.apiStatus,
      this.apiText,
      this.apiVersion,
      this.user_id,
      this.messages,
      this.timezone,
      this.cookie});
  factory SocialMediaModel.fromJson(Map<String,dynamic> json){
    return SocialMediaModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      user_id: json['user_id'],
      messages: json['messages'],
      timezone: json['timezone'],
      cookie: json['cookie'],
    );
  }

  Map<String,dynamic> tojson(){
    Map<String,dynamic> _data = Map<String,dynamic>();
    _data['api_status'] = apiStatus;
    _data['api_text'] = apiText;
    _data['api_version'] = apiVersion;
    _data['user_id'] = user_id;
    _data['messages'] = messages;
    _data['timezone'] = timezone;
    _data['cookie'] = cookie;
    return _data;
  }


}