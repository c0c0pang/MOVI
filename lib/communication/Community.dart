import 'package:flutter/material.dart';
import './evaluation_recommend.dart';
import 'package:get/get.dart';
class COMMUNITY extends StatefulWidget {
  const COMMUNITY({super.key});

  @override
  State<COMMUNITY> createState() => mainCommunityPage();
}

class mainCommunityPage extends State<COMMUNITY> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
              '커뮤니티', style: TextStyle(color: Colors.black, fontSize: 25)),
          centerTitle: false,
          bottom: TabBar(
            tabs: [
              Tab(child: Text('영화평가 & 추천',
                  style: TextStyle(color: Colors.black, fontSize: 18))),
              Tab(child: Text(
                  '자유게시판', style: TextStyle(color: Colors.black, fontSize: 18)))
            ], indicatorColor: Colors.black,
          ),

        ),
        body: TabBarView(
          children: [
            evaluation_recommend(),
            evaluation_recommend(),
          ],
        ),
      ),
    ));
  }
}
