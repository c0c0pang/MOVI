import 'package:flutter/material.dart'; //aaa
import 'ChattingRoom.dart';
const menuFont = 'NanumSquareRound';
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
      appBar: AppBar(
        title: Text('채팅',style: TextStyle(fontSize: 25,color: Colors.black,fontFamily: menuFont,fontWeight: FontWeight.bold)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:
         ChattingRoom(),
    ),
    );
  }
}

