import 'package:flutter/material.dart';
import './communication/Community.dart';
import './matching/Match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MATCH(),
    );
  }
}
