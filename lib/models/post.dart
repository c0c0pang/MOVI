import 'package:flutter/widgets.dart';
class Post{
  String? name;
  IconData? icons;
  String? title;
  String? comments;
  int? like;
  int? reply;
  int? key;
  Post({
    this.name,
    this.icons,
    this.title,
    this.comments,
    this.like,
    this.reply,
    this.key
});
  // @override
  // String toString() => 'Post $like mph';
}