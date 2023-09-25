import 'dart:io';

import 'package:package_http/business/post_manager.dart';

void main() async {
  try {
    int id = 1;

    var post = await fetchPost(id);

    print('Post with $id: $post');

    post.show();

 } on SocketException catch (e) {
    print(e);
  } on HttpException catch (e) {
    print(e);
  } on FormatException catch (e) {
    print(e);
  }
}