import 'package:flutter/material.dart';
import './evaluation_recommend.dart';
import 'package:get/get.dart';

const menuFont = 'NanumSquareRound';

class COMMUNITY extends StatefulWidget {
  const COMMUNITY ({Key? key,required this.id}) :super(key:key);
  final String id;
  @override
  State<COMMUNITY> createState() => mainCommunityPage();
}

class mainCommunityPage extends State<COMMUNITY> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('커뮤니티',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: menuFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            centerTitle: false,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: evaluation_recommend(id:widget.id),
    );
  }
}
