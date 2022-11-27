import 'package:flutter/material.dart';
import 'package:moviproject/models/ChattingRoomModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './ChatPage.dart';
class ChattingRoom extends StatefulWidget {
  const ChattingRoom({Key? key}) : super(key: key);

  @override
  State<ChattingRoom> createState() => ChattingRoomView();
}

class ChattingRoomView extends State<ChattingRoom> {
  List<ChattingRoomModel> data = <ChattingRoomModel>[
    ChattingRoomModel(
        roomTitle: "방 이름1",
        recentMessage: "최근 메시지1",
        icons: Icons.account_circle,
        timestamp: Timestamp(1, 1),
        content: <String>["a","b","c"],
    ),
    ChattingRoomModel(
        roomTitle: "방 이름2",
        recentMessage: "최근 메시지2",
        icons: Icons.account_circle,
        timestamp: Timestamp(2, 2),
      content: <String>["a","b","c"],
    ),
    ChattingRoomModel(
        roomTitle: "방 이름3",
        recentMessage: "최근 메시지3",
        icons: Icons.account_circle,
        timestamp: Timestamp(3, 3),
      content: <String>["a","b","c"],
    ),
    ChattingRoomModel(
        roomTitle: "방 이름4",
        recentMessage: "최근 메시지4",
        icons: Icons.account_circle,
        timestamp: Timestamp(4, 4),
      content: <String>["a","b","c"],
    ),
    ChattingRoomModel(
        roomTitle: "방 이름5",
        recentMessage: "최근 메시지5",
        icons: Icons.account_circle,
        timestamp: Timestamp(5, 5),
      content: <String>["a","b","c"],
    ),
    ChattingRoomModel(
        roomTitle: "방 이름6",
        recentMessage: "최근 메시지5",
        icons: Icons.account_circle,
        timestamp: Timestamp(5, 5),
      content: <String>["a","b","c"],
    ),
    ChattingRoomModel(
        roomTitle: "방 이름7",
        recentMessage: "최근 메시지5",
        icons: Icons.account_circle,
        timestamp: Timestamp(5, 5),
      content: <String>["a","b","c"],
    ),
    ChattingRoomModel(
        roomTitle: "방 이름8",
        recentMessage: "최근 메시지5",
        icons: Icons.account_circle,
        timestamp: Timestamp(5, 5),
      content: <String>["a","b","c"],
    ),
    ChattingRoomModel(
        roomTitle: "방 이름9",
        recentMessage: "최근 메시지5",
        icons: Icons.account_circle,
        timestamp: Timestamp(5, 5),
      content: <String>["a","b","c"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: data.length,
      itemBuilder: (context, int index) {
        return Row(
            children: [
              Expanded(
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      title: Container(
                        child: Text(data[index].roomTitle)
                      ),
                      subtitle: Container(
                        child: Text(data[index].recentMessage),
                      ),
                      leading: Icon(data[index].icons,size: 80),
                      onTap:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>ChatPage(data:data[index])),
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
  }
}
