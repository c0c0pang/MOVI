import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:moviproject/communication/Community.dart';
class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);
  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  FirebaseFirestore fireStore=FirebaseFirestore.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController TextController = TextEditingController();

  String postTitle = '';
  String content = '';

  String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        title: Text('영화평가 & 추천',
            style: TextStyle(color: Colors.black, fontSize: 22)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Flexible(child: Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: TextField(
                controller: titleController,
                style: TextStyle(
                  fontSize: 30,
                ),
                decoration: InputDecoration(
                    border: (InputBorder.none),
                    hintText: '제목입력',
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 30
                    )
                ),
                onChanged: (value){
                  setState(() {
                    postTitle=value;
                  });
                },
                keyboardType: TextInputType.text
            ),
          )),
        Flexible(child: Container(
          padding: EdgeInsets.only(left: 18,right: 18),
          child: TextField(
              controller: TextController,
              decoration: InputDecoration(
                  border: (InputBorder.none),
                  hintText: '본문내용'
              ),
              onChanged: (value){
                setState(() {
                  content=value;
                });
              },
              maxLines: 20,

              keyboardType: TextInputType.text
          ),
        )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
              minimumSize: Size(380, 40),
              textStyle: TextStyle(fontSize: 20)
          ),
            onPressed: (){
            var toDay = DateTime.now();
            String postKey=getRandomString(16);
            var nobleGases = {'54': 'xenon'};
            fireStore.collection('Posts').doc(postKey).set({
              "key":postKey,
              "title":postTitle,
              "explain":content,
              "user":'익명',
              "like":0,
              "reply":0,
              "date":toDay,
              "test":nobleGases
            });
            Navigator.pop(context);
          },child: Text('게시물 올리기'),),
        ],
      ),
    );
  }
}
