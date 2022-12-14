import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import '../page/editProfilePage.dart';
import 'package:progresso/progresso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const menuFont = 'NanumSquareRound';

class PROFILE extends StatefulWidget {
  const PROFILE({Key? key}) : super(key: key);

  @override
  State<PROFILE> createState() => _PROFILEState();
}

class _PROFILEState extends State<PROFILE> {
  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  double Temperature = 0.01;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void setting() {
    fireStore.collection('User').doc('Data').get().then((doc) {
      if (!doc['setting']) {
        fireStore.collection('User').doc('Data').set({
          'name': '${getRandomString(10)}',
          'setting': true,
          'Temperature': 0.01,
          'character': 'boy1.png',
        });
      }
    });
    // fireStore.collection('User').doc('Data').set(
    //   {
    //     'name': '${getRandomString(10)}',
    //     'setting': true,
    //   }
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setting();
  }

  Widget build(BuildContext context) {
    final String UserKey = getRandomString(10);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('프로필',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: menuFont,
                  fontWeight: FontWeight.bold)),
          centerTitle: false,
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: fireStore.collection('User').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xff2A428C),
                        borderRadius: BorderRadius.circular(20)),
                    child: Image.asset('assets/image/${snapshot.data?.docs[0]['character']}', height: 130),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('무비 #${snapshot.data?.docs[0]['name']}', style: TextStyle(fontSize: 25)),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(EDITPROFILE());
                    },
                    child: Container(
                      width: 220,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12),
                      child: Text('프로필 수정',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text('현재 매너온도: ${snapshot.data?.docs[0]['Temperature'] * 10}',
                        style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Progresso(
                      progress: Temperature,
                      progressStrokeCap: StrokeCap.round,
                      backgroundStrokeCap: StrokeCap.round,
                      progressColor: Color(0xffFF9669),
                      progressStrokeWidth: 15,
                      backgroundStrokeWidth: 9,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
