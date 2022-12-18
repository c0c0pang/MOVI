import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_select/awesome_select.dart';
import '../models/area.dart';
import '../models/genre.dart';

const menuFont = 'NanumSquareRound';

class EDITPROFILE extends StatefulWidget {
  const EDITPROFILE({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<EDITPROFILE> createState() => _EDITPROFILEState();
}

class _EDITPROFILEState extends State<EDITPROFILE> {
  double _width = 80.0;
  bool touch1 = true;
  bool touch2 = false;
  bool touch3 = false;
  bool touch4 = false;
  String character = "boy1.png";
  String value_area = '서울';
  String value_genre = '액션';
  String name = '';
  String comment = '';
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final controller_name = TextEditingController();
  final controller_comment = TextEditingController();
  @override
  void _showDialog(String character, String name, String comment,String genre,String area) {
    // print("ㅁㄴㅇ${Get.arguments["id"]}");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog임
        return AlertDialog(
          title: new Text("프로필 수정"),
          content: new Text("프로필을 수정 하시겠습니까??"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          actions: <Widget>[
            new TextButton(
              child: new Text("예"),
              onPressed: () {
                fireStore
                    .collection('User')
                    .doc('${widget.id}')
                    .update(
                    {
                      'name': name,
                      'character': character,
                      'comment' : comment,
                      'genre' : genre,
                      'area' : area,
                    }
                );
                Navigator.pop(context);
              },
            ),
            new TextButton(
              child: new Text("아니요"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('프로필 수정',
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: menuFont)),
        centerTitle: false,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('프로필 캐릭터 선택',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: menuFont)),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      touch1 = true;
                      touch2 = false;
                      touch3 = false;
                      touch4 = false;
                      character = "boy1.png";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: touch1 ? Colors.grey : Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/image/boy1.png',
                          width: _width,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('잼민이',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: menuFont,
                                fontWeight: touch1
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      touch1 = false;
                      touch2 = true;
                      touch3 = false;
                      touch4 = false;
                      character = "boy2.png";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: touch2 ? Colors.grey : Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset('assets/image/boy2.png', width: _width),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('공대생',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: menuFont,
                                fontWeight: touch2
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      touch1 = false;
                      touch2 = false;
                      touch3 = true;
                      touch4 = false;
                      character = "girl1.png";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: touch3 ? Colors.grey : Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset('assets/image/girl1.png', width: _width),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('분홍이',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: menuFont,
                                fontWeight: touch3
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      touch1 = false;
                      touch2 = false;
                      touch3 = false;
                      touch4 = true;
                      character = "girl2.png";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: touch4 ? Colors.grey : Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset('assets/image/girl2.png', width: _width),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('활발이',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: menuFont,
                                fontWeight: touch4
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text('닉네임 설정',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: menuFont)),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                style: TextStyle(fontSize: 18),
                maxLength: 8,
                maxLines: 1,
                controller: controller_name,
                decoration: InputDecoration(
                  fillColor: Color(0xffFFDDDD),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
            Text('한줄 소개',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: menuFont)),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 230,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    comment = value;
                  });
                },
                style: TextStyle(fontSize: 18),
                maxLength: 20,
                maxLines: 1,
                controller: controller_comment,
                decoration: InputDecoration(
                  fillColor: Color(0xffFFDDDD),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),

            Text('장르 설정',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: menuFont)),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              decoration: BoxDecoration(
                  color: Color(0xffFFDDDD),
                  borderRadius: BorderRadius.circular(10)),
              child: SmartSelect<String>.single(
                modalTitle: '장르선택',
                modalHeaderStyle: S2ModalHeaderStyle(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: menuFont,
                      fontWeight: FontWeight.bold),
                  centerTitle: true,
                ),
                title: '장르',
                choiceStyle: S2ChoiceStyle(
                  titleStyle: TextStyle(fontSize: 19),
                ),
                placeholder: value_genre,
                choiceItems: genre,
                onChange: (state) => setState(() => value_genre = state.value),
                selectedValue: '',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('지역 설정',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: menuFont)),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              decoration: BoxDecoration(
                  color: Color(0xffFFDDDD),
                  borderRadius: BorderRadius.circular(10)),
              child: SmartSelect<String>.single(
                modalTitle: '지역선택',
                modalHeaderStyle: S2ModalHeaderStyle(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: menuFont,
                      fontWeight: FontWeight.bold),
                  centerTitle: true,
                ),
                title: '지역',
                choiceStyle: S2ChoiceStyle(
                  titleStyle: TextStyle(fontSize: 19),
                ),
                placeholder: value_area,
                choiceItems: area,
                onChange: (state) => setState(() => value_area = state.value),
                selectedValue: '',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _showDialog(character, name,comment,value_genre,value_area);
              },
              child: Container(
                width: 150,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xffCC2B2B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('수정하기',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: menuFont,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
