class FollowerModel {
   int? apistatus;
   String? apitext;
   String? apiversion;
  var followerData;

  FollowerModel(
      {this.apistatus, this.apitext, this.apiversion, this.followerData});

  factory FollowerModel.fromJson(Map<String, dynamic> json) {
    return FollowerModel(
      apistatus: json['api_status'],
      apitext: json['api_text'],
      apiversion: json['api_version'],
      followerData: json['users'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = Map<String, dynamic>();

    _data['api_status'] = apistatus;
    _data['api_text'] = apitext;
    _data['api_version'] = apiversion;
    _data['users'] = followerData;

    return _data;
  }
}
