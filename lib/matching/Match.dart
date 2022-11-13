import 'package:flutter/material.dart';

class MATCH extends StatefulWidget {
  const MATCH({super.key});

  @override
  State<MATCH> createState() => mainMatchPage();
}

class mainMatchPage extends State<MATCH> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: searchHeader(),
    );
  }

  AppBar searchHeader(){
    return AppBar(
      backgroundColor: Colors.black12,
      title: TextFormField(
        decoration: InputDecoration(
          hintText: '영화제목검색',
          hintStyle: TextStyle(
            color: Colors.black,
          )
        ),
      )
    );
  }
}

