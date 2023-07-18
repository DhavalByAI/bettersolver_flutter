class MessageModel {
   int? apiStatus;
   String? apiText;
   String? apiVersion;
  var users;
  var groups;
  var video_call;
  var video_call_user;
  var audio_call;
  var audio_call_user;
  var agora_call;
  var agora_call_data;
  String? count_notifications;

  MessageModel(
      {this.apiStatus,
      this.apiText,
      this.apiVersion,
      this.users,
      this.groups,
      this.video_call,
      this.video_call_user,
      this.audio_call,
      this.audio_call_user,
      this.agora_call,
      this.agora_call_data,
      this.count_notifications});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      users: json['users'],
      groups: json['groups'],
      video_call: json['video_call'],
      video_call_user: json['video_call_user'],
      audio_call: json['audio_call'],
      audio_call_user: json['audio_call_user'],
      agora_call: json['agora_call'],
      agora_call_data: json['agora_call_data'],
      count_notifications: json['count_notifications'],
    );
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['api_status'] = apiStatus;
    data['api_text'] = apiText;
    data['api_version'] = apiVersion;
    data['users'] = users;
    data['groups'] = groups;
    data['video_call'] = video_call;
    data['video_call_user'] = video_call_user;
    data['audio_call'] = audio_call;
    data['audio_call_user'] = audio_call_user;
    data['agora_call'] = agora_call;
    data['agora_call_data'] = agora_call_data;
    data['count_notifications'] = count_notifications;

    return data;
  }
}
