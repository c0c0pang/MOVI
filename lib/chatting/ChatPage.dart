import 'package:flutter/material.dart';
import 'package:moviproject/models/ChattingRoomModel.dart';
class ChatPage extends StatelessWidget {
  final ChattingRoomModel data;
  final textController= TextEditingController();
  ChatPage({required this.data});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text(data.roomTitle),
      ),
      body: ListView.builder(
          itemCount: data.content.length,
          itemBuilder: (context,int index){
            return ListTile(
              leading: Icon(data.icons),
              title: Text(data.content[index]),
            );
          })
    );
  }
}
