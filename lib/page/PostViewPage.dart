import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../page/ReplyPage.dart';
import '../page/CreateReplyPage.dart';
import 'package:like_button/like_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostViewPage extends StatefulWidget {
  const PostViewPage({Key? key}) : super(key: key);

  @override
  State<PostViewPage> createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  int number = int.parse(Get.arguments['like']);
  bool likecheck = Get.arguments['likecheck'];

  setLike(int num, bool likeState) async {
    await fireStore
        .collection('Posts')
        .doc(Get.arguments['key'])
        .update({
      'like': num,
      'likecheck' : likeState
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        title: Text('영화평가 & 추천',
            style: TextStyle(color: Colors.black, fontSize: 22)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      '${Get.arguments['user']}',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text('${Get.arguments['title']}',
                        style: TextStyle(fontSize: 30)),
                  ),
                  Container(
                    child: Text(
                      '${Get.arguments['explain']}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey.shade400)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 10, bottom: 10),
                    child: LikeButton(
                      likeCount: number,
                      isLiked: likecheck,
                      onTap: (isLiked) {
                        if (isLiked) {
                          number -= 1;
                          print(number);
                          print(isLiked);
                          setLike(number, !isLiked);
                          return Future<bool>.value(false);
                        } else {
                          number += 1;
                          print(number);
                          print(isLiked);
                          setLike(number, !isLiked);
                          return Future<bool>.value(true);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ReplyViewPage('${Get.arguments['key']}'),
            ),
          ],
        ),
      ),
      bottomSheet: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: EdgeInsets.only(bottom: 0),
          child: CreateReply(
              postKey: '${Get.arguments['key']}',
              replyNum: Get.arguments['reply']),
        ),
      ),
    );
  }
}
