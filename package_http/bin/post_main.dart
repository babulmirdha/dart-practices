import 'dart:io';
import 'package:package_http/posts.dart';

void main() async {
  try {
    // int id = 1;
    // var post = await fetchPost(id);
    // print('Post with $id: $post');

    var posts = await fetchPosts();


    posts.forEach((element) {
      element.show();
    });

   // print(posts);

  } on SocketException catch (e) {
    print(e);
  } on HttpException catch (e) {
    print(e);
  } on FormatException catch (e) {
    print(e);
  }
}