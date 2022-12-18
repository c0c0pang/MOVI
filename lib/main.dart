import 'package:flutter/material.dart';
import 'package:moviproject/chatting/Chatting.dart';
import './communication/Community.dart';
import 'matching/Match.dart';
import 'package:firebase_core/firebase_core.dart';
import './home/MoviHome.dart';
import 'package:get/get.dart';
import './profile/Profile.dart';
import 'login.dart';

const menuFont = 'NanumSquareRound';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LOGIN()
    );
  }
}
