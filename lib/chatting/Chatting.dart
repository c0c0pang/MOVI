import 'package:flutter/material.dart';
import './ChattingRoom.dart';
import './FriendList.dart';
class Chatting extends StatefulWidget {
  const Chatting({super.key});

  @override
  State<Chatting> createState() => mainChattingPage();
}

class mainChattingPage extends State<Chatting> with TickerProviderStateMixin {
  late TabController _tc;
  @override
  void initState(){
    _tc = TabController(
      length: 2,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(onPressed: (){}, child: Text("로그인",style: TextStyle(color: Colors.black),),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black12,
                  ),),
                Icon(Icons.add_alert)
              ],
            )
          ),
          Container(
            height: 50,
            child: TabBar(
              controller: _tc,
              tabs: [
                Text('채팅방'),
                Text('친구 목록'),
              ],
              labelColor: Colors.black,  //선택된 Tab 의 label 색상
              unselectedLabelColor: Colors.black,  //선택되지 않은 Tab 의 label 색상
            )
          ),
          Expanded(
              child: TabBarView(
                controller: _tc,
                children: [
                  ChattingRoom(),
                  FriendList(),
                ],
              ))
        ],
      ),
    ),
    );
  }
}

