import 'package:flutter/widgets.dart'; //aaa
import 'package:tuple/tuple.dart';
class ChattingRoomModel {
  final String id; //해당 도큐먼트의 ID를 담기위함.
  final String roomTitle;
  final String recentMessage;
  final IconData? icons;
  final DateTime timestamp;
  final List<Tuple2<int,String>> content;

  ChattingRoomModel({
    this.id = '',
    this.roomTitle = '',
    this.recentMessage='',
    this.icons,
    required this.timestamp,
    required this.content,
  });
}