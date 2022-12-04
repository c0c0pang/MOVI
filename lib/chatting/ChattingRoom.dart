import 'package:flutter/material.dart';
import 'package:moviproject/models/ChattingRoomModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';
import './ChatPage.dart';
import 'package:intl/intl.dart';

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
      timestamp: DateTime.utc(2022,11,20),
      content: <Tuple2<int,String>>[
        Tuple2(1,"1번의 채팅"),
        Tuple2(2,"2번의 askfsdkfndfndgjkngqjkhnrjnfbaklsfhldkgbdkljbagg"
            "gndjsagbnjkaslgbdshjkglbdsjgbsldahgbdslgbhadgbjsglkag"
            "gdbnsagsdahjgbksdgbdasgbadkgbasduigbhsdga"
            "길이테스트"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(4,"4번의 채팅"),
        Tuple2(1,"1번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(2,"2번의 채팅"),
      ]
    ),
    ChattingRoomModel(
      roomTitle: "방 이름2",
      recentMessage: "최근 메시지2",
      icons: Icons.account_circle,
      timestamp: DateTime.utc(2022,11,21),
      content: <Tuple2<int,String>>[
        Tuple2(1,"1번의 채팅"),
        Tuple2(2,"2번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(4,"4번의 채팅"),
        Tuple2(1,"1번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(2,"2번의 채팅"),
      ],
    ),
    ChattingRoomModel(
      roomTitle: "방 이름3",
      recentMessage: "최근 메시지3",
      icons: Icons.account_circle,
      timestamp: DateTime.utc(2022,11,22),
      content: <Tuple2<int,String>>[
        Tuple2(1,"1번의 채팅"),
        Tuple2(2,"2번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(4,"4번의 채팅"),
        Tuple2(1,"1번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(2,"2번의 채팅"),
      ],
    ),
    ChattingRoomModel(
      roomTitle: "방 이름4",
      recentMessage: "최근 메시지4",
      icons: Icons.account_circle,
      timestamp: DateTime.utc(2022,11,23),
      content: <Tuple2<int,String>>[
        Tuple2(1,"1번의 채팅"),
        Tuple2(2,"2번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(4,"4번의 채팅"),
        Tuple2(1,"1번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(2,"2번의 채팅"),
      ],
    ),
    ChattingRoomModel(
      roomTitle: "방 이름5",
      recentMessage: "최근 메시지5",
      icons: Icons.account_circle,
      timestamp: DateTime.utc(2022,11,24),
      content: <Tuple2<int,String>>[
        Tuple2(1,"1번의 채팅"),
        Tuple2(2,"2번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(4,"4번의 채팅"),
        Tuple2(1,"1번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(2,"2번의 채팅"),
      ],
    ),
    ChattingRoomModel(
      roomTitle: "방 이름6",
      recentMessage: "최근 메시지5",
      icons: Icons.account_circle,
      timestamp: DateTime.utc(2022,11,25),
      content: <Tuple2<int,String>>[
        Tuple2(1,"1번의 채팅"),
        Tuple2(2,"2번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(4,"4번의 채팅"),
        Tuple2(1,"1번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(2,"2번의 채팅"),
      ],
    ),
    ChattingRoomModel(
      roomTitle: "방 이름7",
      recentMessage: "최근 메시지5",
      icons: Icons.account_circle,
      timestamp: DateTime.utc(2022,11,26),
      content: <Tuple2<int,String>>[
        Tuple2(1,"1번의 채팅"),
        Tuple2(2,"2번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(4,"4번의 채팅"),
        Tuple2(1,"1번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(2,"2번의 채팅"),
      ],
    ),
    ChattingRoomModel(
      roomTitle: "방 이름8",
      recentMessage: "최근 메시지5",
      icons: Icons.account_circle,
      timestamp: DateTime.utc(2022,11,27),
      content: <Tuple2<int,String>>[
        Tuple2(1,"1번의 채팅"),
        Tuple2(2,"2번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(4,"4번의 채팅"),
        Tuple2(1,"1번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(2,"2번의 채팅"),
      ],
    ),
    ChattingRoomModel(
      roomTitle: "방 이름9",
      recentMessage: "최근 메시지5",
      icons: Icons.account_circle,
      timestamp: DateTime.utc(2022,11,28),
      content: <Tuple2<int,String>>[
        Tuple2(1,"1번의 채팅"),
        Tuple2(2,"2번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(4,"4번의 채팅"),
        Tuple2(1,"1번의 채팅"),
        Tuple2(3,"3번의 채팅"),
        Tuple2(2,"2번의 채팅"),
      ],
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
                      child: ListTile(
                          title: Container(
                            child:Row(
                              children: [
                                Container(
                                    child: Text(data[index].roomTitle),
                                    padding: EdgeInsets.only(right: 5)
                                ),
                                Container(
                                  child:Text(DateFormat('MM-dd').format(data[index].timestamp)
                                      ,style: TextStyle(color: Colors.black26,fontSize: 13)),
                                  padding: EdgeInsets.only(top:7),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.only(top:25),
                          ),
                          subtitle: Container(
                            child: Text(data[index].recentMessage),
                            padding: EdgeInsets.only(top:5)
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
