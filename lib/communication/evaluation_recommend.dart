import 'package:flutter/material.dart';

class evaluation_recommend extends StatefulWidget {
  const evaluation_recommend({Key? key}) : super(key: key);

  @override
  State<evaluation_recommend> createState() => _evaluation_recommendState();
}

class _evaluation_recommendState extends State<evaluation_recommend> {
  TextEditingController _tec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _search();
  }

  Container _search(){
    return Container(
      color: Colors.white,
      child: Column(
          children: <Widget> [Row(
            children: [
              Flexible(
                child: Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 5, top: 15),
                  padding: EdgeInsets.only(left: 5, right: 10),
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.black12)),
                  child: Row(children: <Widget>[
                    Flexible(
                      child: Container(
                        child: TextField(
                          controller: _tec,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '게시물 제목, 내용, 작성자 검색',
                              hintStyle: TextStyle(color: Colors.grey,)),
                          cursorColor: Colors.black12,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20,top: 15),
                child: Icon(Icons.search,size: 35),
              ),
            ],
          ) ]),
    );
  }
}
