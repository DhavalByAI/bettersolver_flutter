class NotificationModel {
   String? apiStatus;
   String? apiText;
   String? apiVersion;
  var notifications;
   String? countNotification;
   String? countFriendRequest;
  var friendRequest;
  var profileUser;
  var trendingHashTag;
  var promotedPage;
   String? countMessage;

  NotificationModel(
      {this.apiStatus,
      this.apiText,
      this.apiVersion,
      this.notifications,
      this.countNotification,
      this.countFriendRequest,
      this.friendRequest,
      this.profileUser,
      this.trendingHashTag,
      this.promotedPage,
      this.countMessage});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      notifications: json['notifications'],
      countNotification: json['count_notifications'],
      countFriendRequest: json['count_friend_requests'],
      friendRequest: json['friend_requests'],
      profileUser: json['pro_users'],
      trendingHashTag: json['trending_hashtag'],
      promotedPage: json['promoted_pages'],
      countMessage: json['count_messages'],
    );
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> _data = Map<String, dynamic>();

    _data['api_status'] = apiStatus;
    _data['api_text'] = apiText;
    _data['api_version'] = apiVersion;

    _data['notifications'] = notifications;

    _data['count_notifications'] = countNotification;
    _data['count_friend_requests'] = countFriendRequest;

    _data['friend_requests'] = friendRequest;
    _data['pro_users'] = profileUser;
    _data['trending_hashtag'] = trendingHashTag;
    _data['promoted_pages'] = promotedPage;

    _data['count_messages'] = countMessage;

    return _data;
  }
}
