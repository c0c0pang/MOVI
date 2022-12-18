import 'package:cloud_firestore/cloud_firestore.dart';

class newChat{
  void sendMessage(String uid,String text,String term,String roomid) async {
    final userData = await FirebaseFirestore.instance.collection('User').doc(
        uid).get();
    FirebaseFirestore.instance.collection(
        'ChatRoom/rPDUIQvCg3PBVxuq3gR6/$term/$roomid/chat').add({
      'id': uid,
      'text': text,
      'time': DateTime.now(),
      'name': userData.data()!['name'],
    });
  }

  void convertMap(Map<String,dynamic> data,String uid) async{
    final userData = await FirebaseFirestore.instance.collection('User').doc(
        uid).get();
    data['name']=userData.data()!['name'];
    data['Temperature']=userData.data()!['Temperature'];
    /*한줄소개,지역,취향,아이콘
    data['Temperature']=userData.data()!['Temperature'];
    data['Temperature']=userData.data()!['Temperature'];
    data['Temperature']=userData.data()!['Temperature'];
    data['Temperature']=userData.data()!['Temperature'];
     */
  }
}