import 'package:flutter/material.dart';
import 'dart:core';
import './ApiModel.dart';
import 'dart:async';
import './Poster_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swipedetector/swipedetector.dart';

const apikey = 'bc44002962513d9b01bc57ea2304acc7';
const baseApi = 'https://image.tmdb.org/t/p/original';

class MOVEAPIPAGE extends StatefulWidget {
  const MOVEAPIPAGE({Key? key}) : super(key: key);

  @override
  State<MOVEAPIPAGE> createState() => _MOVEAPIPAGEState();
}

//https://image.tmdb.org/t/p/original
class _MOVEAPIPAGEState extends State<MOVEAPIPAGE> {
  int currentPage = 0;
  PageController _PageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentPage < 10) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      _PageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeInBack,
      );
    });
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
    // fetchData();
    //Image.network('https://image.tmdb.org/t/p/original/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg'),

    //Image.network('${baseApi}${poster}')
    return Column(
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
                          )
                        )
                      ),
                      // color: Colors.grey,
                      child: PageView.builder(
                          controller: _PageController,
                          onPageChanged: (value) {},
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 450,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${baseApi}${snapshot.data[index]['poster_path']}'),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Container(
                                    child: Text(
                                        '${snapshot.data[index]['title']}'
                                            .toUpperCase(),
                                        style: TextStyle(fontSize: 18),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    Container(
                      alignment: Alignment(-0.8,0),
                      margin: EdgeInsets.only(top: 20),
                      child: Text('무비차트',style: TextStyle(fontSize: 30),)
                    ),
                    Container(
                      child:  Row(
                        children: [
                          Container(
                              child: GestureDetector(
                                onTap: (){},
                                child: Text('예매순',style: TextStyle(fontSize: 15)),
                              ),
                            margin: EdgeInsets.only(left: 30),
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffD9D9D9),
                            ),
                          ),
                          Container(
                              child: GestureDetector(
                                onTap: (){},
                                child: Text('현재상영작',style: TextStyle(fontSize: 15)),
                              ),
                            margin: EdgeInsets.only(left: 10,right: 10),
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffD9D9D9),
                            ),
                          ),
                          Container(
                              child: GestureDetector(
                                onTap: (){},
                                child: Text('상영예정작',style: TextStyle(fontSize: 15)),
                              ),
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffD9D9D9),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 5),

                    ),


                  ],
                );
              }
            }),
      ],
    );
  }
}
