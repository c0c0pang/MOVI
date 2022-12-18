import 'package:flutter/material.dart';
import 'package:moviproject/chatting/Chatting.dart';
import '../communication/Community.dart';
import '../matching/Match.dart';
import 'package:firebase_core/firebase_core.dart';
import '../home/MoviHome.dart';
import 'package:get/get.dart';
import '../profile/Profile.dart';

const menuFont = 'NanumSquareRound';
class START extends StatefulWidget {
  const START({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<START> createState() => _STARTState();
}

class _STARTState extends State<START> {
  final double size = 12.0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: Scaffold(
          body: TabBarView(
            children: [
              MOVIHOME(),
              MATCH(id: widget.id),
              COMMUNITY(id:widget.id),
              Chatting(id:widget.id),
              PROFILE(id: widget.id),
            ],
          ),
          bottomNavigationBar: Container(
            height: 75,
            child: const TabBar(
              indicator: BoxDecoration(
                // color: Colors.grey,
              ),
              unselectedLabelColor: Colors.white,
              labelColor: Colors.black87,
              tabs: [
                Tab(
                  icon: Icon(Icons.home_rounded),
                  child: Text('홈',
                      style:
                      TextStyle(fontFamily: menuFont, color: Colors.black,fontSize:12)),

                ),
                Tab(
                  icon: Icon(Icons.electric_bolt),
                  child: Text('매칭',
                      style:
                      TextStyle(fontFamily: menuFont, color: Colors.black,fontSize:12)),
                ),
                Tab(
                  icon: Icon(Icons.people),
                  child: Text('커뮤니티',
                      style:
                      TextStyle(fontFamily: menuFont, color: Colors.black,fontSize:12)),
                ),
                Tab(
                  icon: Icon(Icons.chat_bubble),
                  child: Text('채팅',
                      style:
                      TextStyle(fontFamily: menuFont, color: Colors.black,fontSize:12)),
                ),
                Tab(
                  icon: Icon(Icons.account_box_rounded),
                  child: Text('프로필',
                      style:
                      TextStyle(fontFamily: menuFont, color: Colors.black,fontSize:12)),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xffF2F2F2),
        ),
      ),
    );
  }
}


/*
* DefaultTabController(
        length: 5,
        child: Scaffold(
          body: const TabBarView(
            children: [
              MOVIHOME(),
              MATCH(),
              // LOGIN(),
              COMMUNITY(),
              Chatting(),
              PROFILE(),
            ],
          ),
          bottomNavigationBar: Container(
            height: 80,
            child: const TabBar(
              indicator: BoxDecoration(
                  // color: Colors.grey,
                  ),
              unselectedLabelColor: Colors.white,
              labelColor: Colors.black87,
              tabs: [
                Tab(
                  icon: Icon(Icons.home_rounded),
                  child: Text('홈',
                      style:
                          TextStyle(fontFamily: menuFont, color: Colors.black)),
                ),
                Tab(
                  icon: Icon(Icons.electric_bolt),
                  child: Text('매칭',
                      style:
                          TextStyle(fontFamily: menuFont, color: Colors.black)),
                ),
                Tab(
                  icon: Icon(Icons.people),
                  child: Text('커뮤니티',
                      style:
                          TextStyle(fontFamily: menuFont, color: Colors.black)),
                ),
                Tab(
                  icon: Icon(Icons.chat_bubble),
                  child: Text('채팅',
                      style:
                          TextStyle(fontFamily: menuFont, color: Colors.black)),
                ),
                Tab(
                  icon: Icon(Icons.account_box_rounded),
                  child: Text('프로필',
                      style:
                          TextStyle(fontFamily: menuFont, color: Colors.black)),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xffF2F2F2),
        ),
      ),*/