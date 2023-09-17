import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

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

Future<Post> fetchPost(int id) async {
  final url = 'https://jsonplaceholder.typicode.com/posts/$id';
  final response = await http.get(Uri.parse(url));

  print(jsonDecode(response.body));

  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw HttpException('${response.statusCode}');
  }
}

Future<List<Post>> fetchPosts() async {
  final url = 'https://jsonplaceholder.typicode.com/posts';

  final response = await http.get(Uri.parse(url));


  var data = jsonDecode(response.body);

  if (response.statusCode == 200) {

    return Post.postList(data);

  } else {
    throw HttpException('${response.statusCode}');
  }
}