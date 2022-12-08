import 'package:flutter/material.dart';
import 'dart:core';
import '../home/ApiModel.dart';
import 'dart:async';
import '../home/Poster_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swipedetector/swipedetector.dart';

const apikey = 'bc44002962513d9b01bc57ea2304acc7';
const baseApi = 'https://image.tmdb.org/t/p/original';

class UPCOMING extends StatefulWidget {
  const UPCOMING({Key? key}) : super(key: key);

  @override
  State<UPCOMING> createState() => _UPCOMINGState();
}

class _UPCOMINGState extends State<UPCOMING> {
  PageController _MoviPageController = PageController(
    initialPage: 0,
  );

  @override
  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=${apikey}&language=en-US&page=1'));
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
                                                    TextStyle(fontSize: 18),
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
                                                Icon(Icons.star),
                                                Text(
                                                    '${snapshot.data[index]['vote_average']}',
                                                    style:
                                                    TextStyle(fontSize: 18),
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
                                        Container(
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
                                                  fit: BoxFit.cover)),
                                        ),
                                        Container(
                                          child: SingleChildScrollView(
                                            child: Text(
                                                '${snapshot.data[index]['overview']}',
                                                style: TextStyle(fontSize: 18),
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
