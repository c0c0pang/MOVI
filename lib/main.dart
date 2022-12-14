import 'package:flutter/material.dart';
import 'package:moviproject/chatting/Chatting.dart';
import 'package:moviproject/message_list_screen.dart';
import './communication/Community.dart';
import 'matching/Match.dart';
import 'package:firebase_core/firebase_core.dart';
import './home/MoviHome.dart';
import 'package:get/get.dart';
import './profile/Profile.dart';
const menuFont = 'NanumSquareRound';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        // debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            body: const TabBarView(
              children: [
                MOVIHOME(),
                MATCH(),
                COMMUNITY(),
                Chatting(),
                PROFILE(),
              ],
            ),
            bottomNavigationBar: Container(
              height: 80,
              child: const TabBar(
                indicator:BoxDecoration(
                  // color: Colors.grey,
                ) ,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.black87,

                tabs: [
                  Tab(
                    icon: Icon(Icons.home_rounded),
                    child: Text('홈',style: TextStyle(fontFamily: menuFont,color: Colors.black)),
                  ),
                  Tab(
                    icon: Icon(Icons.electric_bolt),
                    child: Text('매칭',style: TextStyle(fontFamily: menuFont,color: Colors.black)),
                  ),
                  Tab(
                    icon: Icon(Icons.people),
                    child: Text('커뮤니티',style: TextStyle(fontFamily: menuFont,color: Colors.black)),
                  ),
                  Tab(
                    icon: Icon(Icons.chat_bubble),
                    child: Text('채팅',style: TextStyle(fontFamily: menuFont,color: Colors.black)),
                  ),
                  Tab(
                    icon: Icon(Icons.account_box_rounded),
                    child: Text('프로필',style: TextStyle(fontFamily: menuFont,color: Colors.black)),
                  ),
                ],
              ),
            ),
            backgroundColor: Color(0xffF2F2F2),
          ),
        )
        // home: COMMUNITY(),
        );
  }
}
