class UserTimeLineModel {
   String? apiStatus;
   String? apiText;
   String? apiVersion;
  var posts;
  var friends;
  var textpost;
  var photospost;
  var videopost;
  var musicpost;
  var filepost;
  var mappost;
   String? connectivitysystem;

  UserTimeLineModel(
      {this.apiStatus,
      this.apiText,
      this.apiVersion,
      this.posts,
      this.friends,
      this.textpost,
      this.photospost,
      this.videopost,
      this.musicpost,
      this.filepost,
      this.mappost,
      this.connectivitysystem});

  factory UserTimeLineModel.fromJson(Map<String, dynamic> json) {
    return UserTimeLineModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      posts: json['posts'],
      friends: json['friends'],
      textpost: json['text_post'],
      photospost: json['photos_post'],
      videopost: json['video_post'],
      musicpost: json['music_post'],
      filepost: json['file_post'],
      mappost: json['map_post'],
      connectivitysystem: json['connectivity_system'],
    );
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['api_status'] = apiStatus;
    data['api_text'] = apiText;
    data['api_version'] = apiVersion;
    data['posts'] = posts;
    data['friends'] = friends;
    data['text_post'] = textpost;
    data['photos_post'] = photospost;
    data['video_post'] = videopost;
    data['music_post'] = musicpost;
    data['file_post'] = filepost;
    data['map_post'] = mappost;
    data['connectivity_system'] = connectivitysystem;

    return data;
  }
}
