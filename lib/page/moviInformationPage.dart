import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const menuFont = 'NanumSquareRound';
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

  final double _width = 265.0;
  double _rating = 0.5;
  int Num = 0;
  int _length = 0;

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

  void _showDialog(var id, var rating) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("관람평 작성"),
          content: new Text("관람평을 작성 하시겠습니까?"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          actions: <Widget>[
            new TextButton(
              child: new Text("예"),
              onPressed: () {
                setState(() {
                  fireStore.collection('Review').doc('${id}').set({
                    '익명${_length}': {
                      'who': '익명${_length}',
                      'star': rating * 2,
                      'comment': postReview
                    },
                  }, SetOptions(merge: true));
                });
                reviewController.clear();

                Navigator.pop(context);
              },
            ),
            new TextButton(
              child: new Text("아니요"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //https://api.themoviedb.org/3/movie/436270?api_key=bc44002962513d9b01bc57ea2304acc7&language=ko-K
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        title: Text('평점 및 관람평', style: TextStyle(color: Colors.black,fontFamily: menuFont,fontWeight: FontWeight.bold,fontSize: 23)),
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
                scrollDirection: Axis.vertical,
                child: GestureDetector(
                  onTap: () {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Text("제목: ${Get.arguments['title']}",
                                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: menuFont)),
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
                                        Text("영화관 관람 평점",
                                            style: TextStyle(fontSize: 16)),
                                        SizedBox(
                                          width: 31,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Color(0xffCC2B2B),
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
                            border: Border(bottom: BorderSide(width: 0.2))),
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
                          color: Color(0xffCC2B2B),
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
                            fillColor: Color(0xffF5F1F1),
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
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDialog(Get.arguments['id'], _rating);
                        },
                        child: Container(
                          width: 320,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xffCC2B2B),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text('관람평 올리기',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.2))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder(
                        stream: fireStore
                            .collection('Review')
                            .doc(Get.arguments['id'])
                            .snapshots(),
                        builder: (context, reviewSnaphot) {
                          final items = reviewSnaphot.data?.data();
                          final itemsSize = reviewSnaphot.data?.data()?.length;
                          double sum = 0.0;
                          if (itemsSize != null) {
                            _length = itemsSize;
                            for (var i = 0; i < itemsSize; i++) {
                              sum += items?['익명${i}']['star'];
                            }
                            return Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.star_rounded,
                                        size: 30,
                                        color: Color(0xffCC2B2B),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('회원 관람 평점',
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${(sum / itemsSize).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: ListView.separated(
                                    physics:  const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: itemsSize,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                  title: Text(
                                                    items?['익명${index}']['who'],
                                                  ),
                                                  subtitle: Row(
                                                    children: [
                                                      RatingBarIndicator(
                                                        rating: items?['익명${index}']['star']/2,
                                                        itemBuilder:
                                                            (context, index) =>
                                                                Icon(
                                                          Icons.star_rounded,
                                                          color: Color(0xffCC2B2B),
                                                        ),
                                                        itemCount: 5,
                                                        itemSize: 30.0,

                                                      ),
                                                      Text(
                                                          '${items?['익명${index}']['star']}'),
                                                    ],
                                                  )),
                                              Container(
                                                child: Text(
                                                    '${items?['익명${index}']['comment']}'),
                                                width: 360,
                                              ),
                                            ],
                                          ));
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text('');
                          }
                        },
                      ),
                      // Container(
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.star_rounded),
                      //       Text('회원 관람 평점${}'),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
