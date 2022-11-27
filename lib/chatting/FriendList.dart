import 'package:flutter/material.dart';
import 'package:moviproject/models/FriendModel.dart';
class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  State<FriendList> createState() => FriendListView();
}

class FriendListView extends State<FriendList>{
  List<FriendModel> data=<FriendModel>[
    FriendModel(
      name: "닉네임1",
      icons: Icons.account_circle,
    ),
    FriendModel(
      name: "닉네임2",
      icons: Icons.account_circle,
    ),
    FriendModel(
      name: "닉네임3",
      icons: Icons.account_circle,
    ),
    FriendModel(
      name: "닉네임4",
      icons: Icons.account_circle,
    ),
    FriendModel(
      name: "닉네임5",
      icons: Icons.account_circle,
    ),
    FriendModel(
      name: "닉네임6",
      icons: Icons.account_circle,
    ),
    FriendModel(
      name: "닉네임7",
      icons: Icons.account_circle,
    ),
    FriendModel(
      name: "닉네임8",
      icons: Icons.account_circle,
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
                        Text(data[index].name,
                          style: TextStyle(fontSize: 30),
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
