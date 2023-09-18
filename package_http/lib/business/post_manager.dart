import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/post.dart';

var baseUrl = "https://jsonplaceholder.typicode.com";

Future<Post> fetchPost(int id) async {
  final url = '$baseUrl/posts/$id';
  final response = await http.get(Uri.parse(url));

  print(jsonDecode(response.body));

  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw HttpException('${response.statusCode}');
  }
}

Future<List<Post>> fetchPosts() async {
  final url = '$baseUrl/posts';

  final response = await http.get(Uri.parse(url));

  var data = jsonDecode(response.body);

  if (response.statusCode == 200) {

    List<Post> list = [];

    for (var element in data) {
      list.add(Post.fromJson(element));
    }

    return list;
  } else {
    throw HttpException('${response.statusCode}');
  }
}
