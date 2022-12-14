import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import './moviInformationPage.dart';
const apikey = 'bc44002962513d9b01bc57ea2304acc7';
const baseApi = 'https://image.tmdb.org/t/p/original';
const menuFont = 'NanumSquareRound';
class NOWPlAYING extends StatefulWidget {
  const NOWPlAYING({Key? key}) : super(key: key);

  @override
  State<NOWPlAYING> createState() => _NOWPlAYINGState();
}

class _NOWPlAYINGState extends State<NOWPlAYING> {
  PageController _MoviPageController = PageController(
    initialPage: 0,
  );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
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
                      child: Column(
                        children: [
                          Container(
                            height: 270,
                            child: PageView.builder(
                              controller: _MoviPageController,
                              onPageChanged: (value) {},
                              itemCount: 10,
                              itemBuilder: (context, int index) {
                                return Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment(0.8, 0.2),
                                            child: Row(
                                              children: [
                                                Text(
                                                    '제목: ${snapshot.data[index]['original_title']}',
                                                    style:
                                                        TextStyle(fontSize: 18,
                                                          fontFamily: menuFont,),
                                                    textAlign: TextAlign.left),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text('평점: ',
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                Icon(Icons.star,color: Color(0xffCC2B2B)),
                                                Text(
                                                    '${snapshot.data[index]['vote_average']}',
                                                    style:
                                                        TextStyle(fontSize: 18,
                                                          fontFamily: menuFont,),
                                                    textAlign: TextAlign.left),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      margin:
                                          EdgeInsets.only(left: 20, top: 10),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                            height: 200,
                                            width: 150,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        '${baseApi}${snapshot.data[index]['poster_path']}'),
                                                    //backdrop_path
                                                    //poster_path
                                                    fit: BoxFit.cover)),
                                          ),
                                          onTap: (){
                                            Get.to(MOVIINFORMATINS(),arguments: {
                                              'poster' : '${baseApi}${snapshot.data[index]['poster_path']}',
                                              'title' : '${snapshot.data[index]['original_title']}',
                                              'id': '${snapshot.data[index]['id']}',
                                            });
                                          },
                                        ),
                                        Container(
                                          child: SingleChildScrollView(
                                            child: Text(
                                                '${snapshot.data[index]['overview']}',
                                                style: TextStyle(fontSize: 18,
                                                  fontFamily: menuFont,),
                                                textAlign: TextAlign.left),
                                          ),
                                          width: 230,
                                          height: 210,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
