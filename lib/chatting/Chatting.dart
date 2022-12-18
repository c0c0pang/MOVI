import 'package:flutter/material.dart'; //aaa
import 'LongChattingRoom.dart';
import 'ShortChattingRoom.dart';

const menuFont = 'NanumSquareRound';

class Chatting extends StatefulWidget {
  final String id;

  const Chatting({super.key, required this.id});

  @override
  State<Chatting> createState() => mainChattingPage();
}

class mainChattingPage extends State<Chatting> with TickerProviderStateMixin {
  late TabController _tc;

  @override
  void initState() {
    _tc = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('채팅',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontFamily: menuFont,
                    fontWeight: FontWeight.bold)),
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Column(
            children: [
              TabBar(
                controller: _tc,
                tabs: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text('정기모임', style: TextStyle(fontSize: 20,fontFamily: menuFont))),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text('단기모임', style: TextStyle(fontSize: 20,fontFamily: menuFont)))
                ],
                labelColor: Colors.black,
                //선택된 Tab 의 label 색상
                unselectedLabelColor: Colors.black,
                //선택되지 않은 Tab 의 label 색상
                indicatorColor: Color(0xffCC2B2B),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tc,
                  children: [
                    LongChattingRoom(id: widget.id),
                    ShortChattingRoom(id: widget.id),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
