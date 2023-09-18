

import 'dart:convert';
import 'dart:io';
import 'package:file_read_write/post.dart';

void main(){

 var postsFile = File("assets/posts.json");

 postsFile.readAsString().then((value){

   print(value.runtimeType);
  var data = jsonDecode(value);

  // print(data.runtimeType);

   List<Post> posts = [];
   
   for(var map in data){
    
    var post = Post(title: map['title'], body: map['body']);

    posts.add(post);

  //  print(map.runtimeType);


   // print("");
   }


   for (var p in posts) {

    print("Title: ${p.title}");
    print("Body: ${p.body}");

    //p.show(); // Home work
    print("");

   }





 });


}