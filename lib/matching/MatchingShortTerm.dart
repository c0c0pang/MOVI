import 'package:flutter/material.dart'; //aaa
import 'package:intl/intl.dart';
import 'package:moviproject/chatting/Chatting.dart';
import 'package:moviproject/models/matchModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const baseApi = 'https://image.tmdb.org/t/p/original';

class MatchingShortTerm extends StatefulWidget {
  final String text;
  final String id;
  const MatchingShortTerm({Key? key,required this.text,required this.id}) : super(key: key);
  @override
  State<MatchingShortTerm> createState() => ShortTermState();
}

class ShortTermState extends State<MatchingShortTerm>{
  String docID='';
  String chatDocID='';
  List addList=<String>[];
  int docCurPeople=0;
  @override
  Widget build(BuildContext context){
    if(widget.text=='') {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Match/Eiyq0InEtTTkJPieAflk/shortTerm').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            final docs = snapshot.data?.docs;
            if(snapshot.hasData){
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: docs!.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                        child: Card(
                          elevation: 0,
                          child: Container(
                              height: 120,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  color: Color(0xffF3F3F3),
                                  borderRadius:BorderRadius.circular(10)
                              ),
                              child:Row(children: [
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage('${baseApi}${docs[index]['poster_path']}'),
                                            fit: BoxFit.fill
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 14,
                                  child: Container(
                                    padding: const EdgeInsets.only(top:5,right: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Text(docs[index]['movieTitle'],
                                          style: TextStyle(fontSize: 20,fontFamily: menuFont),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text('날짜',
                                              style: TextStyle(fontSize: 15,fontFamily: menuFont),
                                            ),
                                            Text(DateFormat('MM/dd').format(
                                                docs[index]['date'].toDate()),
                                              style: TextStyle(fontSize: 15,fontFamily: menuFont),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text('모집인원',
                                              style: TextStyle(fontSize: 15,fontFamily: menuFont),
                                            ),
                                            Text(
                                              '${docs[index]['currentPeople']}/${docs[index]['needPeople']}',
                                              style: TextStyle(fontSize: 15,fontFamily: menuFont))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text('지역',
                                              style: TextStyle(fontSize: 15,fontFamily: menuFont),
                                            ),
                                            Text(docs[index]['area'],
                                              style: TextStyle(fontSize: 15,fontFamily: menuFont),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],)
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
                      );
                },
                separatorBuilder: (context, int index) =>
                const Divider(
                  height: 10.0,
                ),
              );
            }
            else{
              return Text('');
            }

          });
    }
    else{
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Match/Eiyq0InEtTTkJPieAflk/shortTerm').where('movieTitle',isEqualTo: widget.text).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            final docs = snapshot.data?.docs;
            if(snapshot.hasData){
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: docs!.length,
                itemBuilder: (context, int index) {
                  return Expanded(
                      child:GestureDetector(
                        child: Card(
                          child: Container(
                              height: 120,
                              padding: const EdgeInsets.all(0),
                              child:Row(children: [
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage('${baseApi}${docs[index]['poster_path']}'),
                                            fit: BoxFit.fill
                                        )
                                    ),
                                  ),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 14,
                                  child: Container(
                                    padding: const EdgeInsets.only(top:5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(docs[index]['movieTitle'],
                                          style: TextStyle(fontSize: 23),
                                        ),
                                        Row(
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
                                        Row(
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
                                        Row(
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
                                      ],
                                    ),
                                  ),
                                )
                              ],)
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
                  );
                },
                separatorBuilder: (context, int index) =>
                const Divider(
                  height: 10.0,
                ),
              );
            }
            else{
              return Text('');
            }
          });
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
                  setState(() {
                    addList.add(widget.id);
                    FirebaseFirestore.instance.collection('Match/Eiyq0InEtTTkJPieAflk/shortTerm')
                        .doc('$docID').update({
                      'userList': addList,
                      'currentPeople': docCurPeople+1,
                    });
                    FirebaseFirestore.instance.collection('ChatRoom/rPDUIQvCg3PBVxuq3gR6/shortTerm')
                        .doc('$chatDocID').update({
                      'userList': addList,
                    });
                    joinMessage();
                    Navigator.pop(context);
                  });
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

  void joinMessage(){
    //참가 데베 넣기
    Fluttertoast.showToast(
      msg: "참가되었습니다.",
      gravity: ToastGravity.BOTTOM,
    );
  }
}