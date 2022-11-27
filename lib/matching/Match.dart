import 'package:flutter/material.dart';
import './MatchingLongTerm.dart';
import './MatchingShortTerm.dart';
class MATCH extends StatefulWidget {
  const MATCH({super.key});

  @override
  State<MATCH> createState() => mainMatchPage();
}

class mainMatchPage extends State<MATCH> with TickerProviderStateMixin {
  late TabController _tc;
  @override
  void initState(){
    _tc = TabController(
      length: 2,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body: Column(
        children: [
          TextField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '영화제목 검색',
                hintStyle: TextStyle(
                  color: Colors.grey,
                )),
            cursorColor: Colors.black12,
          ),
          TabBar(
            controller: _tc,
            tabs: [
            Text('장기모임'),
            Text('단기모임'),
          ],
          labelColor: Colors.black,  //선택된 Tab 의 label 색상
            unselectedLabelColor: Colors.black,  //선택되지 않은 Tab 의 label 색상
          ),
          Expanded(
              child: TabBarView(
                controller: _tc,
                children: [
                  MatchingLongTerm(),
                  MatchingShortTerm(),
                ],
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> addMatchPage()),
          );

        },
        child: Icon(Icons.add_circle),
      ),
    ),
    );
  }
}

class addMatchPage extends StatelessWidget{
  final areaTextController= TextEditingController();
  final timeTextController= TextEditingController();
  final dateTextController= TextEditingController();
  final peopleTextController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        height: 500,

        padding: EdgeInsets.all(50),
        margin: EdgeInsets.all(50),

        decoration: BoxDecoration(
          color:Colors.black45,

          borderRadius: BorderRadius.all(
            Radius.circular(70),
          )
        ),
        child:Expanded(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Row(
                    children:<Widget> [
                      SizedBox(width: 30,),
                      new Text(
                        "지역",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontFamily: 'jua', fontSize: 20,color: Colors.white),
                      ),
                      SizedBox(width: 30,),
                      Container(
                        child: new Flexible(
                          child: new TextField(
                            controller: areaTextController,
                          ),
                        ),
                        width: 100, //TextField 크기
                      ),
                    ],
                  ),
                  Row(
                    children:<Widget> [
                      SizedBox(width: 30,),
                      new Text(
                        "시간",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontFamily: 'jua', fontSize: 20,color: Colors.white),
                      ),
                      SizedBox(width: 30,),
                      Container(
                        child: new Flexible(
                          child: new TextField(
                            controller: timeTextController,
                          ),
                        ),
                        width: 100, //TextField 크기
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children:<Widget> [
                      SizedBox(width: 30,),
                      new Text(
                        "날짜",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontFamily: 'jua', fontSize: 20,color: Colors.white),
                      ),
                      SizedBox(width: 30,),
                      Container(
                        child: new Flexible(
                          child: new TextField(
                            controller: dateTextController,
                          ),
                        ),
                        width: 100, //TextField 크기
                      ),
                    ],
                  ),
                  Row(
                    children:<Widget> [
                      SizedBox(width: 30,),
                      new Text(
                        "인원",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontFamily: 'jua', fontSize: 20,color: Colors.white),
                      ),
                      SizedBox(width: 30,),
                      Container(
                        child: new Flexible(
                          child: new TextField(
                            controller: peopleTextController,
                          ),
                        ),
                        width: 100, //TextField 크기
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child:Container(
                      color: Colors.white54,
                      child:OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          "게시물 올리기",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  )
                ],
              )
            ],
          )
        )

      ),
    );
  }
}

