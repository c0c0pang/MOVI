import 'package:flutter/material.dart';
class COMMUNITY extends StatefulWidget {
  const COMMUNITY({super.key});

  @override
  State<COMMUNITY> createState() => mainCommunityPage();
}

class mainCommunityPage extends State<COMMUNITY>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('커뮤니티',style: TextStyle(color: Colors.black,fontSize: 25)),
        centerTitle: false,
        elevation: 0,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                    ),
                  )
              ),
              child: Text('영화평가 & 추천',style: TextStyle(fontSize: 23)),
            ),
          ),

          Container(
            child: Text('자유게시판',style: TextStyle(fontSize: 23)),
          ),
        ],
      ),
    );
  }
}
