import 'dart:io';
import 'package:package_http/business/post_manager.dart';

void main() async {
  try {

    var posts = await fetchPosts();

    posts.forEach((post) {
      post.show();
    });


  } on SocketException catch (e) {
    print(e);
  } on HttpException catch (e) {
    print(e);
  } on FormatException catch (e) {
    print(e);
  }
}