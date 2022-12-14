import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Widget ReplyViewPage(postKey) {
  return StreamBuilder(
    stream:  FirebaseFirestore.instance.collection('Reply').doc(postKey).snapshots(),
    builder: (context,replySnaphot){
      final items = replySnaphot.data?.data();
      final itemsSize = replySnaphot.data?.data()?.length;
      print(itemsSize);
      print(items?['${0}']['who']);
      if(itemsSize!=null){
        return Container(
          height: 470,
          child: ListView.separated(
            // physics:  const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount:  itemsSize,
            itemBuilder: (BuildContext context, int index){
              return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  height: 100,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(items?['${index}']['who']),
                        subtitle: Text(items?['${index}']['comment']),
                      ),
                    ],
                  )
              );
            },
            separatorBuilder: (BuildContext context,int index) => const Divider(
              height: 10,
            ),
          ),
        );

      }
      else{
        return Text('');
      }

      },
      );
    }

//Padding(padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
//         child: Column(
//           children: [
//             Container(
//               child: Text(postKey),
//             ),
//             Container(
//               child: Text(postKey),
//             ),
//           ],
//         ),
//       );