import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './MoveApiPage.dart';
import 'package:get/get.dart';
class MOVIHOME extends StatefulWidget {
  const MOVIHOME({Key? key}) : super(key: key);

  @override
  State<MOVIHOME> createState() => _MOVEHOMEState();
}

class _MOVEHOMEState extends State<MOVIHOME> {
  TextEditingController _tec = TextEditingController();
  bool searchTogle = false;
  Widget searchBar(){
    if(searchTogle){
      return Flexible(
        child: Container(
          alignment: Alignment(0.0, 0.0),
          width: 260,
          margin: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1, color: Colors.black12),
          ),
          child: Row(children: <Widget>[
            Flexible(
              child: Container(
                child: TextField(
                  controller: _tec,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '게시물 제목, 내용, 작성자 검색',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.all(8),
                  ),
                  cursorColor: Colors.black12,
                ),
              ),
            ),
          ]),
        ),
      );
    }
    else{
      return SizedBox(
        width: 0,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Image.asset('assets/image/Logo.png'),
        actions: [
          searchBar(),
          IconButton(
              onPressed: () {
                setState(
                  () {
                    if (searchTogle) {
                      searchTogle = false;
                    } else {
                      searchTogle = true;
                    }
                  },
                );
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.black,
                size: 28,
              )),
        ],
      ),
      body: MOVEAPIPAGE(),
    );
  }
}
