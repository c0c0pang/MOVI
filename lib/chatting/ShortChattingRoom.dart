import 'package:flutter/material.dart'; //aaaa
import 'package:moviproject/models/ChattingRoomModel.dart';
import 'package:tuple/tuple.dart';
import 'ChatPage.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShortChattingRoom extends StatefulWidget {
  final String id;
  const ShortChattingRoom({Key? key,required this.id}) : super(key: key);

  @override
  State<ShortChattingRoom> createState() => ChattingRoomView();
}

class ChattingRoomView extends State<ShortChattingRoom> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('ChatRoom/rPDUIQvCg3PBVxuq3gR6/shortTerm')
          .where('userList',arrayContains: widget.id).snapshots(),
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
                          height: 100,
                          child: ListTile(
                              title: Container(
                                child:Row(
                                  children: [
                                    Container(
                                        child: Text(docs[index]['roomTitle']),
                                        padding: EdgeInsets.only(right: 5)
                                    ),
                                    Container(
                                      child:Text(DateFormat('MM-dd').format(docs[index]['recentMsgTime'].toDate())
                                          ,style: TextStyle(color: Colors.black26,fontSize: 13)),
                                      padding: EdgeInsets.only(top:7),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.only(top:25),
                              ),
                              subtitle: Container(
                                  child: Text(docs[index]['recentMsg']),
                                  padding: EdgeInsets.only(top:5)
                              ),
                              leading: Icon(Icons.account_circle,size: 80), //재설정 필요
                              onTap:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>ChatPage( id: widget.id,
                                    roomDocs: docs[index].id,longTerm: false,roomTitle: docs[index]['roomTitle'],)),
                                );
                              }
                          )
                      )
                  )
                ]
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
