import 'package:flutter/material.dart'; //aaaa
import 'package:moviproject/models/FriendModel.dart';
class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  State<FriendList> createState() => FriendListView();
}

class FriendListView extends State<FriendList>{
  int user_index=-1;
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
              Expanded(
                child: Container(
                  height: 100,
                  child: ListTile(
                    title:Container(
                      child: Text(data[index].name,style: TextStyle(
                          fontSize: 20,
                      ),),
                      padding: EdgeInsets.only(top:35),
                    ),
                    leading: Icon(data[index].icons,size: 80),
                    onTap: (){
                      user_index=index; //user key
                      showModalBottomSheet(context: context, builder: buildBottomSheet);
                    },
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
  Widget buildBottomSheet(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Icon(data[user_index].icons,size:100),
        ),//아이콘
        Container(
          child: Text(data[user_index].name)
        ),//닉네임
        Container(
          child: Text("온도 들어가는곳"),
        ),//온도
        Container(
          child: Column(
            children: [
              Container(
                child: Text("한 줄 소개"),
              ),
              Container()
            ],
          ),
        ),//한줄소개
        Container(child: Column(
          children: [
            Container(
              child: Text("지역"),
            ),
            Container()
          ],
        ),),//지역
        Container(child: Column(
          children: [
            Container(
              child: Text("관심 장르"),
            ),
            Container()
          ],
        ),),//관심장르
        Container(
          child: Row(
            children: [
              OutlinedButton(
                onPressed: ()=> upTempurture(),
                child: Text("온도 올리기"),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  )
                )),
              OutlinedButton(
                  onPressed: ()=> downTempurture(),
                  child: Text("온도 내리기"),
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
  }

  //온도 조절하는 기능이 들어갈 함수 db연동시 여기에 기능  넣으면 됨
  void upTempurture(){
    print("온도 올라감");
  }

  void downTempurture(){
    print("온도 내려감");
  }
}
