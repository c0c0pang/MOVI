import 'package:flutter/material.dart'; //aaa
import 'package:moviproject/models/ChattingRoomModel.dart';
import 'package:intl/intl.dart';
import 'package:moviproject/models/UserModel.dart';
import 'package:tuple/tuple.dart';
class ChatPage extends StatefulWidget {
  final ChattingRoomModel data;
  final textController= TextEditingController();
  ChatPage({required this.data});
  var _userEnterMessage = '';

  @override
  ChatPageState createState()=>new ChatPageState();
}

class ChatPageState extends State<ChatPage>{
  ScrollController _scrollController=ScrollController();
  List<UserModel> userData=<UserModel>[
    UserModel(
        idkey: 1,
        icons: Icons.account_circle,
        nickname: "user1"
    ),
    UserModel(
        idkey: 2,
        icons: Icons.account_circle,
        nickname: "user2"
    ),
    UserModel(
        idkey: 3,
        icons: Icons.account_circle,
        nickname: "user3"
    ),
    UserModel(
        idkey: 4,
        icons: Icons.account_circle,
        nickname: "user4"
    ),
  ];
  int user_idkey=1;
  int user_index=-1;
  List<Tuple2<int,String>> messageData=[];
  @override
  Widget build(BuildContext context){
    messageData=widget.data.content;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black
          ),//back 버튼 색깔 표시 해야함
          backgroundColor: Colors.white,
          title:  Text(widget.data.roomTitle,
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

  int findKey(int idkey){
    for(int i=0;i<userData.length;i++){
      if(userData[i].idkey==idkey){
        return i;
      }
    }
    return -1;
  }

  void _sendMessage(){
    widget.data.content.add(Tuple2(user_idkey,widget._userEnterMessage));
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
    return ListView.builder(
        reverse: true,
        itemCount: messageData.length,
        itemBuilder: (context,int index){
          int lastIndex=messageData.length-1;
          int chatUseridIndex=findKey(messageData[lastIndex-index].item1);
          bool isMe=user_idkey==messageData[lastIndex-index].item1;//나중에 join연산으로 하면 되는 기능
          return chatBubble(isMe, lastIndex-index, chatUseridIndex);
        });
  }

  Widget chatBubble(bool isMe,int index,int chatUseridIndex){
    if(isMe){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              decoration: BoxDecoration(
                color: isMe? Colors.grey[300] : Colors.blue,
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
              child: Text(
                messageData[index].item2,
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
                    icon: Icon(userData[chatUseridIndex].icons),
                    onPressed: (){
                      user_index=chatUseridIndex;
                      showModalBottomSheet(context: context, builder: buildBottomSheet);
                    },
                  )
              ),
              Container(
                child: Text(userData[chatUseridIndex].nickname),
              )
            ],
          ),
          Container(
              decoration: BoxDecoration(
                color: isMe? Colors.grey[300] : Colors.blue,
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
              child: Text(
                messageData[index].item2,
                style: TextStyle(
                    color: Colors.white
                ),)
          )
        ],
      );
    }
  }

  //friendlist와 공유해야함
  Widget buildBottomSheet(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Icon(userData[user_index].icons,size:100),
        ),//아이콘
        Container(
            child: Text(userData[user_index].nickname)
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
              Container(
                  child: Text("안녕하세요 저는 영화를 좋아합니다.")
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
                child: Text("서울")
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
                    Text("액션"),
                    Text("스릴러"),
                    Text("로맨스"),
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
                  onPressed: ()=> upTempurture(),
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
                  onPressed: ()=> downTempurture(),
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
  }

  //온도 조절하는 기능이 들어갈 함수 db연동시 여기에 기능  넣으면 됨
  void upTempurture(){
    print("온도 올라감");
  }

  void downTempurture(){
    print("온도 내려감");
  }
}