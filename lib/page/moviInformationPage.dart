import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const apikey = 'bc44002962513d9b01bc57ea2304acc7';

class MOVIINFORMATINS extends StatefulWidget {
  const MOVIINFORMATINS({Key? key}) : super(key: key);

  @override
  State<MOVIINFORMATINS> createState() => _MOVIINFORMATINSState();
}

class _MOVIINFORMATINSState extends State<MOVIINFORMATINS> {
  late ScrollController _scrollController;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  TextEditingController reviewController = TextEditingController();
  String postReview = '';
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${Get.arguments['id']}?api_key=${apikey}&language=ko-KR'));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }

  double _width = 265;
  double _rating = 0.5;

  //https://api.themoviedb.org/3/movie/436270?api_key=bc44002962513d9b01bc57ea2304acc7&language=ko-K
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        title: Text('평점 및 관람평', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: getJsonData(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            } else {
              return SingleChildScrollView(
                controller: _scrollController,
                child: GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: 110,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image:
                                      NetworkImage(Get.arguments['poster']),
                                      //backdrop_path
                                      //poster_path
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Text("제목: ${Get.arguments['title']}",
                                        style: TextStyle(fontSize: 18)),
                                    width: _width,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                        "장르: ${snapshot.data['genres'][0]['name']}",
                                        style: TextStyle(fontSize: 15)),
                                    width: _width,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                            "${snapshot.data['release_date']} 개봉",
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.access_time_rounded,
                                                size: 15),
                                            Text("${snapshot.data['runtime']}분",
                                                style: TextStyle(fontSize: 15)),
                                          ],
                                        )
                                      ],
                                    ),
                                    width: _width,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("관람객 평점",
                                            style: TextStyle(fontSize: 16)),
                                        SizedBox(
                                          width: 60,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            "${snapshot.data['vote_average'].toStringAsFixed(1)}",
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    width: _width,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.5))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('평점 및 리뷰', style: TextStyle(fontSize: 20)),
                      RatingBar.builder(
                        itemSize: 40,
                        initialRating: 0.5,
                        minRating: 0.5,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('평점: ${(_rating * 2).toInt()}',
                          style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 320,
                        child: TextField(
                          controller: reviewController,
                          onChanged: (value) {
                            setState(() {
                              postReview = value;
                            });
                          },
                          onTap: () {
                            _scrollController.animateTo(50,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          maxLength: 300,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            // counterStyle: TextStyle(height: 1)
                          ),
                          maxLines: 8,
                          minLines: 8,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          width: 320,
                          decoration: BoxDecoration(
                            color: Colors.grey
                          ),
                          child: Text('asd'),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
