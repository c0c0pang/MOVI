import 'package:flutter/material.dart';
import 'package:moviproject/chatting/Chatting.dart';
import 'package:moviproject/message_list_screen.dart';
import './communication/Community.dart';
import './matching/Match.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import './home/MoviHome.dart';
import 'dart:async';
import 'package:get/get.dart';
const menuFont = 'NanumSquareRound';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp(
  //);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        // debugShowCheckedModeBanner: false,
        home: Container(
          child: Container(
            child: DefaultTabController(
              length: 5,
              child: Scaffold(
                body: TabBarView(
                  children: [
                    MOVIHOME(),
                    Text('마이 스크린'),
                    COMMUNITY(),
                    Text('채팅 스크린'),
                    Text('마이 스크린'),
                  ],
                ),
                bottomNavigationBar: Container(
                  height: 80,
                  child: TabBar(
                    indicator:BoxDecoration(
                      color: Colors.grey,
                    ) ,
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.black87,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.home),
                        child: Text('홈',style: TextStyle(fontFamily: menuFont)),
                      ),
                      Tab(
                        icon: Icon(Icons.electric_bolt),
                        child: Text('매칭',style: TextStyle(fontFamily: menuFont)),
                      ),
                      Tab(
                        icon: Icon(Icons.people),
                        child: Text('커뮤니티',style: TextStyle(fontFamily: menuFont)),
                      ),
                      Tab(
                        icon: Icon(Icons.chat_bubble),
                        child: Text('채팅',style: TextStyle(fontFamily: menuFont)),
                      ),
                      Tab(
                        icon: Icon(Icons.account_box_rounded),
                        child: Text('프로필',style: TextStyle(fontFamily: menuFont)),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        )
        // home: COMMUNITY(),
        );
  }
}
