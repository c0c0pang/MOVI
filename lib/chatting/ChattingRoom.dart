import 'package:flutter/material.dart';
import 'package:moviproject/models/ChattingRoomModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        timestamp: Timestamp(1, 1)
    ),
    ChattingRoomModel(
        roomTitle: "방 이름2",
        recentMessage: "최근 메시지2",
        icons: Icons.account_circle,
        timestamp: Timestamp(2, 2)
    ),
    ChattingRoomModel(
        roomTitle: "방 이름3",
        recentMessage: "최근 메시지3",
        icons: Icons.account_circle,
        timestamp: Timestamp(3, 3)
    ),
    ChattingRoomModel(
        roomTitle: "방 이름4",
        recentMessage: "최근 메시지4",
        icons: Icons.account_circle,
        timestamp: Timestamp(4, 4)
    ),
    ChattingRoomModel(
        roomTitle: "방 이름5",
        recentMessage: "최근 메시지5",
        icons: Icons.account_circle,
        timestamp: Timestamp(5, 5)
    ),
    ChattingRoomModel(
        roomTitle: "방 이름6",
        recentMessage: "최근 메시지5",
        icons: Icons.account_circle,
        timestamp: Timestamp(5, 5)
    ),
    ChattingRoomModel(
        roomTitle: "방 이름7",
        recentMessage: "최근 메시지5",
        icons: Icons.account_circle,
        timestamp: Timestamp(5, 5)
    ),
    ChattingRoomModel(
        roomTitle: "방 이름8",
        recentMessage: "최근 메시지5",
        icons: Icons.account_circle,
        timestamp: Timestamp(5, 5)
    ),
    ChattingRoomModel(
        roomTitle: "방 이름9",
        recentMessage: "최근 메시지5",
        icons: Icons.account_circle,
        timestamp: Timestamp(5, 5)
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
              Icon(
                data[index].icons,
                size: 100,
              ),
              Expanded(
                  child: Container(
                    height: 140,
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data[index].roomTitle,
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(data[index].recentMessage,
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
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
