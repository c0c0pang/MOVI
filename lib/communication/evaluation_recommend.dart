import 'package:flutter/material.dart';

class evaluation_recommend extends StatefulWidget {
  const evaluation_recommend({Key? key}) : super(key: key);

  @override
  State<evaluation_recommend> createState() => _evaluation_recommendState();
}

class _evaluation_recommendState extends State<evaluation_recommend> {
  TextEditingController _tec = TextEditingController();
  List<String> title = <String>[
    '클레멘타인 이 영화 꼭 봐야함',
    '잉여왕 이 영화 꼭 봐야함',
    '바람둥이왕 신권일 이 영화 꼭 봐야함',
    'last stardust 이 영화 꼭 봐야함',
    '패션왕 이 영화 꼭 보면 안돼'
  ];
  List<String> users = <String>[
    '익명1',
    '익명2',
    '익명3',
    '익명4',
    '익명5',
  ];
  final List<IconData> icons = <IconData>[
    Icons.account_circle,
    Icons.account_circle,
    Icons.account_circle,
    Icons.account_circle,
    Icons.account_circle,
  ];

  final List<String> comments = <String>[
    "아무내용...",
    "아무내용...",
    "아무내용...",
    "아무내용...",
    "아무내용...",
  ];
  final List<int> favorite = <int>[
    1,
    2,
    3,
    4,
    5,
  ];
  final List<int> reply = <int>[
    2,
    4,
    6,
    2,
    6,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: _search(),
        ),
        Container(
          margin: EdgeInsets.only(top: 88),
          child: _postCard(),
        ),
        Container(
          child: _postWrite(),
        ),
        Container(
          margin: EdgeInsets.only(top: 55),
          child: _Sort(),
        ),
      ],
    );
  }

  Widget _Sort() {
    return Container(
        margin: EdgeInsets.only(top: 10, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 15),
              child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.swap_vert,
                        size: 25,
                      ),
                      Text('최신순'),
                    ],
                  )),
            ),
            Container(
              child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 25,
                      ),
                      Text('좋아요순')
                    ],
                  )),
            ),
          ],
        ));
  }

  Widget _postCard() {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: title.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey[100],
          margin: EdgeInsets.all(3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: 90,
              child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        color: Colors.grey[1],
                        size: 35,
                      ),
                      Text('${users[index]}',
                          style: TextStyle(height: 1.5, fontSize: 13)),
                    ],
                  ),

                  title: Container(
                    margin: EdgeInsets.only(top: 10),
                    child:Text('제목 : ${title[index]}'),
                  ),
                  subtitle: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text('내용 : ${comments[index]}',
                            style: TextStyle(height: 2)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 150, top: 20, right: 10),
                        child: Row(
                          children: [
                            Icon(Icons.favorite,
                                size: 20, color: Colors.redAccent),
                            Text('${favorite[index]}'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_outline, size: 20),
                            Text('${reply[index]}'),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ]),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _postWrite() {
    return Container(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            print('포스팅 업로드');
          },
          child: Container(
            margin: EdgeInsets.all(40),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: Colors.grey[300],
            ),
            child: Icon(Icons.create, size: 30),
          ),
        ));
  }

  Widget _search() {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        Row(
          children: [
            Flexible(
              child: Container(
                alignment: Alignment(0.0, 0.0),
                height: 45,
                margin: EdgeInsets.only(left: 10, right: 5, top: 15),
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
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                        cursorColor: Colors.black12,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 7, top: 15),
              child: Icon(Icons.search, size: 35),
            ),
          ],
        )
      ]),
    );
  }
}
