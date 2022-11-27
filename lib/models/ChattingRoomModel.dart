import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChattingRoomModel {
  final String id; //해당 도큐먼트의 ID를 담기위함.
  final String roomTitle;
  final String recentMessage;
  final IconData? icons;
  final Timestamp? timestamp;
  final List<String> content;


  ChattingRoomModel({
    this.id = '',
    this.roomTitle = '',
    this.recentMessage='',
    this.icons,
    this.timestamp,
    required this.content,
  });


}