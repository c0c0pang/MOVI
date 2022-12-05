import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './MoveApiPage.dart';
class MOVIHOME extends StatefulWidget {
  const MOVIHOME({Key? key}) : super(key: key);

  @override
  State<MOVIHOME> createState() => _MOVEHOMEState();
}

class _MOVEHOMEState extends State<MOVIHOME> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.local_fire_department_rounded,color: Colors.red),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black,size: 30,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.black,size: 28,))
        ],
      ),
      body: MOVEAPIPAGE(),
    );

  }
}
