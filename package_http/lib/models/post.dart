class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }


  static List<Post> postList(List<dynamic> json){

    List<Post> list = [];

    for (var element in json) {
      list.add(Post.fromJson(element));
    }

    return list;
  }

  @override
  String toString() {
    return title;
  }

  void show() {
    print("Title: ${title}");
    print("Body: ${body}");
    print("");
  }
}
