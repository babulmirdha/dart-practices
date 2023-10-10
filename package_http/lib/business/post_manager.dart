import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/post.dart';

var baseUrl = "https://jsonplaceholder.typicode.com";

Future<Post> fetchPost(int id) async {
  final url = '$baseUrl/posts/$id';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {

  var map = jsonDecode(response.body);

    return Post(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );

   // return Post.fromJson(jsonDecode(response.body));
  } else {
    throw HttpException('${response.statusCode}');
  }
}

Future<List<Post>> fetchPosts() async {
  final url = '$baseUrl/posts';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {

    var data = jsonDecode(response.body);

    List<Post> list = [];

    for (var map in data) {
     var post = Post.fromJson(map);
      list.add(post);
    }

    return list;
  } else {
    throw HttpException('${response.statusCode}');
  }
}
