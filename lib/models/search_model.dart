class SearchModel{

   String? apistatus;
   String? apitext;
   String? apiversion;
  var user;
  var group;

  SearchModel(
      {this.apistatus, this.apitext, this.apiversion, this.user, this.group});

  factory SearchModel.fromJson(Map<String,dynamic> json){

    return SearchModel(
      apistatus: json['api_status'],
      apitext: json['api_text'],
      apiversion: json['api_version'],
      user: json['user'],
      group: json['group'],
    );
  }

  Map<String,dynamic> toJson () {
    Map<String,dynamic> data = Map<String,dynamic>();

    data['api_status'] = apistatus;
    data['api_text'] = apitext;
    data['api_version'] = apiversion;
    data['user'] = user;
    data['group'] = group;

    return data;
  }
}