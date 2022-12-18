import 'package:flutter/material.dart'; //aaa
import 'package:moviproject/models/ChattingRoomModel.dart';
import 'package:intl/intl.dart';
import 'package:moviproject/models/UserModel.dart';
import 'package:tuple/tuple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviproject/chatting/newChat.dart';

class ChatPage extends StatefulWidget {
  final String roomDocs;
  final bool longTerm;
  final String roomTitle;
  final String id;
  final textController= TextEditingController();
  ChatPage({required this.id,required this.roomDocs,required this.longTerm,required this.roomTitle});
  var _userEnterMessage = '';

  @override
  ChatPageState createState()=>new ChatPageState();
}

class ChatPageState extends State<ChatPage>{
  ScrollController _scrollController=ScrollController();
  late String roomDoc;
  late String term;
  late String selectid;
  late double selectUserTemp;
  late Map<String,dynamic> userData;
  @override
  Widget build(BuildContext context){
    roomDoc=widget.roomDocs;
    if(widget.longTerm){
      term="longTerm";
    }
    else {
      term = "shortTerm";
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black
          ),//back 버튼 색깔 표시 해야함
          backgroundColor: Colors.white,
          title:  Text(widget.roomTitle,
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: messageLog(context)
              ),
              newMessage(),
            ],
          ),
        )
    );
  }


  void _sendMessage(){
    newChat().sendMessage(widget.id, widget._userEnterMessage, term, roomDoc);
    FirebaseFirestore.instance.collection('ChatRoom/rPDUIQvCg3PBVxuq3gR6/$term')
        .doc('$roomDoc').update({
      'recentMsg':widget._userEnterMessage,
      'recentMsgTime':DateTime.now(),
    });
    widget.textController.clear();

  }

  Widget newMessage(){
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: widget.textController,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value){
                setState(() {
                  widget._userEnterMessage=value;
                });
              },
              onTap:(){
                _scrollController.animateTo(120.0, duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
            ),
          ),
          IconButton(
            onPressed: (){
              setState(() {
                _sendMessage();
              });
            },
            icon: Icon(Icons.send),
            color: Color(0xffCC2B2B),
          ),
        ],
      ),
    );
  }
  Widget messageLog(BuildContext context){
    return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('ChatRoom/rPDUIQvCg3PBVxuq3gR6/$term/$roomDoc/chat').orderBy('time',descending: true).snapshots(),
    builder: (BuildContext context,
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      final docs = snapshot.data!.docs;
      return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context,int index){
            return chatBubble(docs[index]['id'],docs[index]['text'],docs[index]['time'],docs[index]['name']);
          });
    });
  }

  Widget chatBubble (String id,String text,Timestamp time,String name){
    if(id==widget.id){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              decoration: BoxDecoration(
                color:  Colors.grey[300],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)
                ),
              ),
              width: 145,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(text,
                style: TextStyle(
                    color:  Colors.black
                ),)
          )
        ],
      );
    }
    else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                  child : IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: (){
                      selectid=id;
                      showModalBottomSheet(context: context, builder: buildBottomSheet);
                    },
                  )
              ),
              Container(
                child: Text(name),
              )
            ],
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)
                ),
              ),
              width: 145,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(text,
                style: TextStyle(
                    color: Colors.white
                ),)
          )
        ],
      );
    }
  }
  void inputname(String id) async{
    late String name;
    final ref=FirebaseFirestore.instance.collection('User').doc(id);
    await ref.get().then(
            (DocumentSnapshot doc) {
          final data=doc.data() as Map<String,dynamic>;
          name= data['name'];
        });

  }
  Widget buildBottomSheet(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('User').where('id',isEqualTo: selectid).snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        final docs=snapshot.data!.docs;
        return ListView.separated(
          itemCount: docs.length,
          itemBuilder: (context,int index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Icon(Icons.account_circle,size:100),
                ),//아이콘
                Container(
                  child: Text(docs[index]['name']),
                ),//닉네임
                Container(
                  child: Text(docs[index]["Temperature"].toString()),
                ),//온도
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text("한 줄 소개"),
                      ),
                      Container(
                          child: Text(docs[index]['comment'])
                      )
                    ],
                  ),
                ),//한줄소개
                Container(child: Column(
                  children: [
                    Container(
                      child: Text("지역"),
                    ),
                    Container(
                        child: Text(docs[index]['area'])
                    )
                  ],
                ),),//지역
                Container(child: Column(
                  children: [
                    Container(
                      child: Text("관심 장르"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(docs[index]['genre'])
                          ],
                        )
                    )
                  ],
                ),),//관심장르
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: (){
                            selectUserTemp=docs[index]['Temperature'];
                            upTempurture();},
                          child: Text("온도 올리기",style: TextStyle(color: Colors.black,fontSize: 16)),
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              )
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      OutlinedButton(
                          onPressed: (){
                            selectUserTemp=docs[index]['Temperature'];
                            downTempurture();},
                          child: Text("온도 내리기",style: TextStyle(color: Colors.black,fontSize: 16)),
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              )
                          ))//오르기
                    ],
                  ),
                ),//온도 버튼
              ],
            );
          },
          separatorBuilder: (context,int index)=>
              const Divider(
                height: 10.0,
              )
          );
      },
    );
  }

  //온도 조절하는 기능이 들어갈 함수 db연동시 여기에 기능  넣으면 됨
  void upTempurture(){
    FirebaseFirestore.instance.collection('User').doc(selectid).update({
      'Temperature':selectUserTemp+1,
    });
    print("온도 올라감");
  }

  void downTempurture(){
    FirebaseFirestore.instance.collection('User').doc(selectid).update({
      'Temperature':selectUserTemp-1,
    });
    print("온도 내려감");
  }
}