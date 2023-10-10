import 'dart:io';

import 'package:package_http/business/post_manager.dart';

void main() async {
  try {
    int id = 2;

    var post = await fetchPost(id);

    print('Post id: $id');

    post.show();

 } on SocketException catch (e) {
    print(e);
  } on HttpException catch (e) {
    print(e);
  } on FormatException catch (e) {
    print(e);
  }
}