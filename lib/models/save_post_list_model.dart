class SavePostListModel {
   String? apiStatus;
   String? apiText;
   String? apiVersion;
   int? total_posts;
   int? total_page;
  var posts;
  var post_likes;
  var post_wonders;

  SavePostListModel(
      {this.apiStatus,
      this.apiText,
      this.apiVersion,
      this.total_posts,
      this.total_page,
      this.posts,
      this.post_likes,
      this.post_wonders});

  factory SavePostListModel.fromJson(Map<String, dynamic> json) {
    return SavePostListModel(
      apiStatus: json['api_status'],
      apiText: json['api_text'],
      apiVersion: json['api_version'],
      total_posts: json['total_posts'],
      total_page: json['total_page'],
      posts: json['posts'],
      post_likes: json['post_likes'],
      post_wonders: json['post_wonders'],
    );
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['api_status'] = apiStatus;
    data['api_text'] = apiText;
    data['api_version'] = apiVersion;
    data['total_posts'] = total_posts;
    data['total_page'] = total_page;
    data['posts'] = posts;
    data['post_likes'] = post_likes;
    data['post_wonders'] = post_wonders;
    return data;
  }
}
