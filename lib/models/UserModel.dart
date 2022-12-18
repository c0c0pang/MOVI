import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart'; //aaa
class UserModel {
  final String id;
  final String password;
  final String name;
  final double Tempurature;
  //final IconData? icons;

  UserModel({
    this.id = '',
    this.password='',
    this.name='',
    this.Tempurature=0,
    //this.icons,
  });

  factory UserModel.fromMap({required String id,required Map<String,dynamic> map}){
    return UserModel(
      id: id,
      name: map['name']??'',
      Tempurature: map['Tempurature']??'',
    );
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> data = {};
    data['name']=name;
    data['Tempurature']=Tempurature;
    return data;
  }

}