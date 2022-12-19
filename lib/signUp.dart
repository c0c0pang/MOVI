import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SIGNUP extends StatefulWidget {
  const SIGNUP({Key? key}) : super(key: key);

  @override
  State<SIGNUP> createState() => _SIGNUPState();
}

class _SIGNUPState extends State<SIGNUP> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  String id = '';
  String password = '';
  String rePassword = '';
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  double Temperature = 0.01;
  getData(String _id,String _password) async{
    var check = await fireStore.collection('User').doc('${_id}').get();
    if(check.exists){
      showDialog(
          context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("아이디 중복"),
          content: new Text("아이디를 다시 입력 해주세요"),
          shape:
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
        );
      });
    }
    else{
      await fireStore.collection('User').doc('${_id}').set({
        'name': '${getRandomString(10)}',
        'Temperature': 0.01,
        'character': 'boy1.png',
        'id': _id,
        'password': _password,
        "area":"",
        "comment":"",
        "genre":""
      });
      idController.clear();
      passwordController.clear();
      showDialog(
          context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("회원가입 성공"),
          content: new Text("이제 앱을 이용해보세요!"),
          shape:
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('회원가입', style: TextStyle(color: Colors.black, fontSize: 25)),
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                child: Image.asset('assets/image/Logo.png', width: 120),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: '아이디',
                    filled: true,
                    fillColor: Color(0xffF5F1F1),
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
                  controller: idController,
                  onChanged: (value) {
                    setState(() {
                      id = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                child: TextField(
                  obscureText: true,
                  maxLines: 1,
                  maxLength: 12,
                  decoration: InputDecoration(
                    hintText: '비밀번호',
                    filled: true,
                    fillColor: Color(0xffF5F1F1),
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
                  controller: passwordController,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                child: TextField(
                  obscureText: true,
                  maxLines: 1,
                  maxLength: 12,
                  decoration: InputDecoration(
                    hintText: '비밀번호 확인',
                    filled: true,
                    fillColor: Color(0xffF5F1F1),
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
                  controller: rePasswordController,
                  onChanged: (value) {
                    setState(() {
                      rePassword = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (id.length <= 3) {
                    showDialog(
                        context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("아이디"),
                        content: new Text("아이디는 최소 4자리 이상입니다."),
                        shape:
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      );
                    });
                  }
                  else if (password.length <= 5) {
                    showDialog(
                        context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("비밀번호"),
                        content: new Text("비밀번호는 최소 6자리 이상입니다."),
                        shape:
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      );
                    });
                  }
                  else if (password != rePassword){
                    showDialog(
                        context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("비밀번호 다름"),
                        content: new Text("비밀번호를 확인해주세요"),
                        shape:
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      );
                    });
                  }
                  else{
                    getData(id,password);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFF7474),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('입력완료',
                      style: TextStyle(color: Colors.white, fontSize: 19)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
