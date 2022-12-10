import 'package:flutter/widgets.dart'; //aaaa
class FriendModel{
  final String id; //해당 도큐먼트의 ID를 담기위함.
  final String name;
  final IconData? icons;

  FriendModel({
    this.id = '',
    this.name='',
    this.icons,
  });
}