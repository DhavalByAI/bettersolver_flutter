class FollowingModel {
   int? apistatus;
   String? apitext;
   String? apiversion;
  var followingData;
  var online;

  FollowingModel(
      {this.apistatus,
      this.apitext,
      this.apiversion,
      this.followingData,
      this.online});

  factory FollowingModel.fromJson(Map<String, dynamic> json) {
    return FollowingModel(
      apistatus: json['api_status'],
      apitext: json['api_text'],
      apiversion: json['api_version'],
      followingData: json['users'],
      online: json['online'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = Map<String, dynamic>();

    _data['api_status'] = apistatus;
    _data['api_text'] = apitext;
    _data['api_version'] = apiversion;
    _data['users'] = followingData;
    _data['online'] = online;

    return _data;
  }
}
