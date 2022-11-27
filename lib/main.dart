import 'package:flutter/material.dart';
import 'package:moviproject/chatting/Chatting.dart';
import 'package:moviproject/message_list_screen.dart';
import './communication/Community.dart';
import './matching/Match.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp(
  //);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Chatting(),
    );
  }
}
