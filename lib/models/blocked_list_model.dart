class BlockedListModel {
   int? apiStatus;

   String? apiText;

   String? apiVersion;

  var blocked_users;

  BlockedListModel(
      {this.apiStatus, this.apiText, this.apiVersion, this.blocked_users});

  factory BlockedListModel.fromJson(Map<String, dynamic> json) {
    return BlockedListModel(
        apiStatus: json['api_status'],
        apiText: json['api_text'],
        apiVersion: json['api_version'],
        blocked_users: json['blocked_users']);
  }

  Map<String, dynamic> tojason() {
    Map<String, dynamic> _data = Map<String, dynamic>();
    _data['api_status'] = apiStatus;
    _data['api_text'] = apiText;
    _data['api_version'] = apiVersion;
    _data['blocked_users'] = blocked_users;

    return _data;
  }
}
