import 'package:flutter/material.dart';
import './MatchingLongTerm.dart';
import './MatchingShortTerm.dart';
class MATCH extends StatefulWidget {
  const MATCH({super.key});

  @override
  State<MATCH> createState() => mainMatchPage();
}
/*
class mainMatchPage extends State<MATCH> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
              '커뮤니티', style: TextStyle(color: Colors.black, fontSize: 25)),
          centerTitle: false,
          bottom: TabBar(
            tabs: [
              Tab(child: Text('장기모임',
                  style: TextStyle(color: Colors.black, fontSize: 18))),
              Tab(child: Text(
                  '단기모임', style: TextStyle(color: Colors.black, fontSize: 18)))
            ], indicatorColor: Colors.black,
          ),

        ),
        body: TabBarView(
          children: [
            MatchingLongTerm(),
            MatchingShortTerm(),
          ],
        ),
      ),
    ));
  }
}
 */

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
    )
    );
  }
}

