import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  FirebaseFirestore fireStore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영화평가 & 추천',
            style: TextStyle(color: Colors.black, fontSize: 22)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle,
                color: Colors.grey[1],
                size: 35,
              ),
              Text('익명', style: TextStyle(height: 1.5, fontSize: 13)),
            ],
          ),
          TextField(),
          TextField(),
          ElevatedButton(onPressed: (){},child: Text('게시글 작성'),),
        ],
      ),
    );
  }
}
