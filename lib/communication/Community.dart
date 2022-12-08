import 'package:flutter/material.dart';
import './evaluation_recommend.dart';
import 'package:get/get.dart';
const menuFont = 'NanumSquareRound';

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
              '커뮤니티', style: TextStyle(color: Colors.black,fontFamily:menuFont,fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: false,
          elevation: 0,
        ),
        body: evaluation_recommend(),
      ),
    ));
  }
}
