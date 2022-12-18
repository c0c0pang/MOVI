import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
import '../page/CreatePostPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../page/PostViewPage.dart';

const menuFont = 'NanumSquareRound';

class evaluation_recommend extends StatefulWidget {
  const evaluation_recommend({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<evaluation_recommend> createState() => _evaluation_recommendState();
}

class _evaluation_recommendState extends State<evaluation_recommend> {
  List<Post> userTable = <Post>[
    Post(
      name: '익명5',
      icons: Icons.account_circle,
      title: '클레멘타인 이 영화 꼭 봐야함',
      comments: "아무내용...",
      like: 1,
      reply: 5,
      key: 5,
    ),
    Post(
      name: '익명4',
      icons: Icons.account_circle,
      title: '바람둥이왕 신권일 이 영화 꼭 봐야함',
      comments: "아무내용...",
      like: 2,
      reply: 5,
      key: 4,
    ),
    Post(
      name: '익명3',
      icons: Icons.account_circle,
      title: '잉여왕 이 영화 꼭 봐야함',
      comments: "아무내용...",
      like: 3,
      reply: 6,
      key: 3,
    ),
    Post(
      name: '익명2',
      icons: Icons.account_circle,
      title: 'last stardust 이 영화 꼭 봐야함',
      comments: "아무내용...",
      like: 5,
      reply: 2,
      key: 2,
    ),
    Post(
      name: '익명1',
      icons: Icons.account_circle,
      title: '패션왕 이 영화 꼭 보면 안돼',
      comments: "아무내용...",
      like: 4,
      reply: 5,
      key: 1,
    ),
  ];
  TextEditingController _tec = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onNewRefresh() async {
    await Future.delayed(Duration(microseconds: 100));
    setState(() {
      userTable.sort((a, b) => b.key!.compareTo(a.key!));
    });
    _refreshController.refreshCompleted();
  }

  void _onLikeRefresh() async {
    await Future.delayed(Duration(microseconds: 100));
    setState(() {
      userTable.sort((a, b) => b.like!.compareTo(a.like!));
    });
    _refreshController.refreshCompleted();
  }

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
                  onTap: () {
                    _onNewRefresh();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.swap_vert,
                        size: 25,
                      ),
                      Text('최신순', style: TextStyle(fontFamily: menuFont)),
                    ],
                  )),
            ),
            Container(
              child: GestureDetector(
                  onTap: () {
                    _onLikeRefresh();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 25,
                      ),
                      Text('좋아요순', style: TextStyle(fontFamily: menuFont))
                    ],
                  )),
            ),
          ],
        ));
  }

  Widget _postCard() {
    // getData();
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
        builder: (context, snapshot) {
          final items = snapshot.data?.docs;
          if(snapshot.hasData){
            return ListView.separated(
              padding: EdgeInsets.all(8),
              itemCount: items!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(PostViewPage(), arguments: {
                          'user': '${items[index]['user']}',
                          'title': '${items[index]['title']}',
                          'explain': '${items[index]['explain']}',
                          'like': '${items[index]['like']}',
                          'key': '${items[index]['key']}',
                          'reply': items[index]['reply'],
                          'likecheck':items[index]['likecheck'],
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),

                        child: ListTile(
                          leading: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Color(0xff2B438D),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Image.asset(
                                    'assets/image/${items[index]['character']}',
                                    width: 29,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text('${items[index]['user']}',
                                    style: TextStyle(
                                        height: 1.5,
                                        fontFamily: menuFont,
                                        fontSize: 13)),
                              ],
                            ),
                          ),
                          title: Container(
                            width: 200,
                            margin: EdgeInsets.only(top: 20),
                            child: Text('제목 : ${items[index]['title']}',
                                style: TextStyle(fontFamily: menuFont),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                          subtitle: Row(
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  '내용 : ${items[index]['explain']}',
                                  style: TextStyle(
                                      height: 2, fontFamily: menuFont),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          horizontalTitleGap: 20,

                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            margin:
                            EdgeInsets.only(left: 310, right: 10),
                            child: Row(
                              children: [
                                Icon(Icons.favorite,
                                    size: 17, color: Colors.redAccent),
                                Text('${items[index]['like']}',
                                    style: TextStyle(fontFamily: menuFont)),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(Icons.chat_bubble_outline, size: 17),
                                Text('${items[index]['reply']}',
                                    style: TextStyle(fontFamily: menuFont)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                );

              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          }
          else{
            return Text('');
          }

        });
  }

  Widget _postWrite() {
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("게시물 작성"),
            content: new Text("게시물을 작성 하시겠습니까?"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            actions: <Widget>[
              new TextButton(
                child: new Text("예"),
                onPressed: () {
                  Navigator.pop(context);
                  Get.to(CreatePostPage(id: widget.id));
                },
              ),
              new TextButton(
                child: new Text("아니요"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            _showDialog();
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 35, right: 15),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: Color(0xffDE3425),
            ),
            child: Icon(Icons.create, size: 30, color: Colors.white),
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
                        keyboardType: TextInputType.text,
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
