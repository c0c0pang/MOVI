import 'package:flutter/material.dart';
import 'dart:core';
import './ApiModel.dart';
import 'dart:async';
import './Poster_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swipedetector/swipedetector.dart';
import '../page/nowPlayingPage.dart';
import '../page/upcomingPage.dart';
import '../page/popularPage.dart';
import 'dart:math';
const apikey = 'bc44002962513d9b01bc57ea2304acc7';
const baseApi = 'https://image.tmdb.org/t/p/original';
const titleFont = 'Maplestory';
const menuFont = 'NanumSquareRound';
class MOVEAPIPAGE extends StatefulWidget {
  const MOVEAPIPAGE({Key? key}) : super(key: key);

  @override
  State<MOVEAPIPAGE> createState() => _MOVEAPIPAGEState();
}
//https://image.tmdb.org/t/p/original
class _MOVEAPIPAGEState extends State<MOVEAPIPAGE> {
  int currentPage = 0;
  int moviCurrentPage = 0;
  PageController _PageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );
  PageController _MoviPageController = PageController(
    initialPage: 0,
  );
  Color _color1 = Color(0xffEBEBEB);
  Color _color2 = Color(0xffEBEBEB);
  Color _color3 = Color(0xffEBEBEB);
  bool selected1 = true;
  bool selected2 = true;
  bool selected3 = true;
  Widget chartSelect() {
    if(selected1 == true){
      return POPULAR();
    }
    else if(selected2==false){
      return NOWPlAYING();
    }
    else{
      return UPCOMING();
    }
  }
  @override

  void initState() {
    super.initState();
    currentPage = Random().nextInt(10);
  }

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=${apikey}&language=en-US&page=1'));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData)['results'];
      return parsingData;
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
              future: getJsonData(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return CircularProgressIndicator();
                } else {
                  return Column(
                    children: [
                      Container(
                        height: 525,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black12,
                        ))),
                        // color: Colors.grey,
                        child:  Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${baseApi}${snapshot.data[currentPage]['poster_path']}'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Container(
                          alignment: Alignment(-0.8, 0),
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            '무비차트',
                            style: TextStyle(fontSize: 30,fontFamily: menuFont,fontWeight: FontWeight.bold),
                          )),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected1 = true;
                                    selected2 = true;
                                    selected3 = true;
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  margin: EdgeInsets.only(left: 30),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selected1 == true
                                        ? Color(0xffD9D9D9)
                                        : Color(0xffEBEBEB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('인기작',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: menuFont,
                                      )),
                                  height: 20,
                                ),
                              ),
                            ),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected1 = false;
                                    selected2 = false;
                                    selected3 = true;
                                  });
                                },
                                child: Container(
                                  width: 85,
                                  height: 20,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selected2 == true
                                        ? Color(0xffEBEBEB)
                                        : Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('현재상영작',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: menuFont,
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected1 = false;
                                    selected2 = true;
                                    selected3 = false;
                                  });
                                },
                                child: Container(
                                  width: 85,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selected3 == true
                                        ? Color(0xffEBEBEB)
                                        : Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('상영예정작',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: menuFont,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(top: 5),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      chartSelect(),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}
