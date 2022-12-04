import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';
class UserModel {
  final int idkey; //해당 도큐먼트의 ID를 담기위함.
  final String id;
  final String password;
  final String nickname;
  final double mannerTempurture;
  final IconData? icons;

  UserModel({
    required this.idkey,
    this.id = '',
    this.password='',
    this.nickname='',
    this.mannerTempurture=0,
    this.icons,
  });


}