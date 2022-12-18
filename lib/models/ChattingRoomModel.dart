import 'package:flutter/widgets.dart'; //aaa
import 'package:tuple/tuple.dart';
class ChattingRoomModel {
  final String id; //해당 도큐먼트의 ID를 담기위함.
  final String roomTitle;
  final String recentMessage;
  final IconData? icons;
  final DateTime recentMsgTime;
  final List<Tuple3<String,String,DateTime>> content; //nickname,msg,timestamp
  final String recentMsg;

  ChattingRoomModel({
    this.id = '',
    this.roomTitle = '',
    this.recentMessage='',
    this.icons,
    required this.recentMsgTime,
    required this.content,
    this.recentMsg='',
  });
}