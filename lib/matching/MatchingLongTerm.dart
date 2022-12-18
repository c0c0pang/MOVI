import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; //aaa
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:moviproject/models/matchModel.dart';

class MatchingLongTerm extends StatefulWidget {
  final String text;
  final String id;
  const MatchingLongTerm({Key? key,required this.text,required this.id}) : super(key: key);
  @override
  State<MatchingLongTerm> createState() => LongTermState();
}

class LongTermState extends State<MatchingLongTerm>{
  String docID='';
  String chatDocID='';
  List addList=<String>[];
  int docCurPeople=0;
  @override
  Widget build(BuildContext context) {
    if (widget.text == '') {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Match/Eiyq0InEtTTkJPieAflk/longTerm').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          final docs = snapshot.data!.docs;
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: docs.length,
            itemBuilder: (context, int index) {
              return Row(
                children: [
                  Expanded(
                      child: Container(
                          child: ListTile(
                            title: Container(
                              child: Text(docs[index]['movieTitle'],
                                style: TextStyle(fontSize: 23),
                              ),
                            ),
                            subtitle: Container(
                              child: Column(
                                //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text('날짜',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(DateFormat('MM/dd').format(
                                            docs[index]['date'].toDate()),
                                          style: TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text('모집인원',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(
                                          '${docs[index]['currentPeople']}/${docs[index]['needPeople']}',
                                          style: TextStyle(fontSize: 17),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text('지역',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(docs[index]['area'],
                                          style: TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              if (docs[index]['userList'].contains(widget.id)) {
                                Fluttertoast.showToast(
                                  msg: "이미 가입된 매칭입니다.",
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                              else {
                                docID=docs[index].id;
                                chatDocID=docs[index]['chatRoomid'];
                                addList=docs[index]['userList'];
                                docCurPeople=docs[index]['currentPeople'];
                                showModalBottomSheet(
                                    context: context,
                                    builder: buildBottomSheet);
                              }
                            },
                          )
                      )
                  )
                ],
              );
            },
            separatorBuilder: (context, int index) =>
            const Divider(
              height: 10.0,
            ),
          );
        },
      );
    }
    else{
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Match/Eiyq0InEtTTkJPieAflk/longTerm').where('movieTitle',isEqualTo: widget.text).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          final docs = snapshot.data!.docs;
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: docs.length,
            itemBuilder: (context, int index) {
              return Row(
                children: [
                  Expanded(
                      child: Container(
                          child: ListTile(
                            title: Container(
                              child: Text(docs[index]['movieTitle'],
                                style: TextStyle(fontSize: 23),
                              ),
                            ),
                            subtitle: Container(
                              child: Column(
                                //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text('날짜',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(DateFormat('MM/dd').format(
                                            docs[index]['date'].toDate()),
                                          style: TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text('모집인원',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(
                                          '${docs[index]['currentPeople']}/${docs[index]['needPeople']}',
                                          style: TextStyle(fontSize: 17),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text('지역',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(docs[index]['area'],
                                          style: TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              if (docs[index]['userList'].contains(widget.id)) {
                                Fluttertoast.showToast(
                                  msg: "이미 가입된 매칭입니다.",
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                              else {
                                docID=docs[index].id;
                                chatDocID=docs[index]['chatRoomid'];
                                addList=docs[index]['userList'];
                                docCurPeople=docs[index]['currentPeople'];
                                print(chatDocID);
                                showModalBottomSheet(
                                    context: context,
                                    builder: buildBottomSheet);
                              }
                            },
                          )
                      )
                  )
                ],
              );
            },
            separatorBuilder: (context, int index) =>
            const Divider(
              height: 10.0,
            ),
          );
        },
      );
    }
  }
  Widget buildBottomSheet(BuildContext context) {

    return Container(
        child: Column(
          children: [
            Container(
                child:Text("해당 매칭에 참가하시겠습니까?")
            ),

            OutlinedButton(
                onPressed: (){
                  addList.add(widget.id);
                  //매칭 리스트 추가
                  FirebaseFirestore.instance.collection('Match/Eiyq0InEtTTkJPieAflk/longTerm')
                      .doc('$docID').update({
                    'userList': addList,
                    'currentPeople': docCurPeople+1,
                  });
                  //채팅 참가
                  FirebaseFirestore.instance.collection('ChatRoom/rPDUIQvCg3PBVxuq3gR6/longTerm')
                      .doc('$chatDocID').update({
                    'userList': addList,
                  });
                  joinMessage();
                  Navigator.pop(context);
                },
                child: Text("예"),
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    )
                )),
          ],
        )
    );
  }
}


void joinMessage(){
  //참가 데베 넣기
  Fluttertoast.showToast(
    msg: "참가되었습니다.",
    gravity: ToastGravity.BOTTOM,
  );
}

