import 'package:flutter/material.dart';
import 'signUp.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './main/startPage.dart';


class LOGIN extends StatefulWidget {
  const LOGIN({Key? key}) : super(key: key);

  @override
  State<LOGIN> createState() => _LOGINState();
}

class _LOGINState extends State<LOGIN> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String id = '';
  String password = '';
  FirebaseFirestore fireStore=FirebaseFirestore.instance;
  getData(String _id,String _password) async{
    print(_id.isEmpty);
    var check = await fireStore.collection("User").doc('${_id}').get();
    if(check.exists){
      var password_check = check.data();
      if(password_check?['password']==_password){
        idController.clear();
        passwordController.clear();
        Navigator.push(context, MaterialPageRoute(builder: (context)=> START(id: _id)));
      }
      else{
        showDialog(
            context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("비밀번호 다름"),
            content: new Text("비밀번호를 확인 해주세요"),
            shape:
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
          );
        });
      }
    }
    else{
      showDialog(
          context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("아이디 없음"),
          content: new Text("아이디를 다시 확인 해주세요"),
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                child: Image.asset('assets/image/Logo.png',width: 120),
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
                  controller:idController,
                  onChanged: (value){
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
                  controller:passwordController,
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
               GestureDetector(
                  onTap: (){
                    getData(id,password);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xffFF7474),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text('로그인',style: TextStyle(color: Colors.white,fontSize: 19)),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(SIGNUP());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFF7465),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text('회원가입',style: TextStyle(color: Colors.white,fontSize: 19)),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
