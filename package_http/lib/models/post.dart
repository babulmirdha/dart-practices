class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
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
