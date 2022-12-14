import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateReply extends StatefulWidget {
  final String? postKey;
  final int? replyNum;

  const CreateReply({Key? key, @required this.postKey, @required this.replyNum})
      : super(key: key);

  @override
  State<CreateReply> createState() => _CreateReplyState();
}

class _CreateReplyState extends State<CreateReply> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  TextEditingController replyController = TextEditingController();
  String postReply = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.only(left: 5, right: 10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffF5F1F1),
        ),
        child: Row(
          children: [
            // Text('${widget.replyNum}'),
            Flexible(
              child: TextField(
                controller: replyController,
                style: TextStyle(
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  border: (InputBorder.none),
                  hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                ),
                onChanged: (value) {
                  setState(() {
                    postReply = value;
                  });
                },
                onTap: (){

                },
                keyboardType: TextInputType.text,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send,color: Color(0xffCC2B2B),),
                onPressed: () {
                  setState(() {
                    fireStore.collection('Reply').doc('${widget.postKey}').set({
                      '${widget.replyNum}': {
                        'who': '익명${widget.replyNum}',
                        'comment': postReply
                      }
                    }, SetOptions(merge: true));
                    fireStore
                        .collection('Posts')
                        .doc('${widget.postKey}')
                        .update({
                      'reply': widget.replyNum! + 1,
                    });
                  });

                  replyController.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
