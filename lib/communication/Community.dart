import 'package:flutter/material.dart';
class COMMUNITY extends StatefulWidget {
  const COMMUNITY({super.key});

  @override
  State<COMMUNITY> createState() => mainCommunityPage();
}

class mainCommunityPage extends State<COMMUNITY>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('커뮤니티',style: TextStyle(color: Colors.black)),
        centerTitle: false,
        elevation: 0,
      ),
    );
  }
}
