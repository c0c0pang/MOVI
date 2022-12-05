import 'package:flutter/material.dart';
import './communication/Community.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import './home/MoviHome.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  margin: EdgeInsets.only(bottom: 5),
                  child: TabBar(
                    indicator:BoxDecoration(color: Colors.grey,) ,
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.black87,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.home),
                        text: 'home',
                      ),
                      Tab(
                        icon: Icon(Icons.chat),
                        text: 'chat',
                      ),
                      Tab(
                        icon: Icon(Icons.people),
                        text: '커뮤니티',
                      ),
                      Tab(
                        icon: Icon(Icons.home),
                        text: 'home',
                      ),
                      Tab(
                        icon: Icon(Icons.account_box_rounded),
                        text: '프로필',
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
