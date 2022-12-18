import 'package:flutter/material.dart'; //aaa
import 'package:intl/intl.dart';
import './MatchingLongTerm.dart';
import 'MatchingShortTerm.dart';
import 'package:moviproject/models/matchModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviproject/chatting/newChat.dart';
import 'package:moviproject/home/ApiModel.dart';

const menuFont = 'NanumSquareRound';
const apikey = 'bc44002962513d9b01bc57ea2304acc7';

class MATCH extends StatefulWidget {
  const MATCH({super.key, required this.id});

  final String id;

  @override
  State<MATCH> createState() => mainMatchPage();
}

class mainMatchPage extends State<MATCH> with TickerProviderStateMixin {
  late TabController _tc;
  String text = '';
  DateTime? _dateTime = DateTime.now();
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    _tc = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  TextEditingController _tec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: Text('매칭',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: menuFont,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment(0.0, 0.0),
                          height: 45,
                          margin: EdgeInsets.only(left: 10, right: 5, top: 15),
                          padding: EdgeInsets.only(left: 5, right: 10),
                          decoration: new BoxDecoration(
                            color: Color(0xffF5F1F1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(children: <Widget>[
                            Flexible(
                              child: Container(
                                child: TextField(
                                  controller: _tec,
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '영화 제목 검색',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      )),
                                  cursorColor: Colors.black12,
                                  onSubmitted: (String str) {
                                    setState(() {
                                      text = str;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 7, top: 15),
                        child: Icon(Icons.search, size: 35),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TabBar(
              controller: _tc,
              tabs: [
                Container(
                    padding: EdgeInsets.all(5),
                    child: Text('정기모임',
                        style: TextStyle(fontSize: 20, fontFamily: menuFont))),
                Container(
                    padding: EdgeInsets.all(5),
                    child: Text('단기모임',
                        style: TextStyle(fontSize: 20, fontFamily: menuFont))),
              ],
              labelColor: Colors.black,
              //선택된 Tab 의 label 색상
              unselectedLabelColor: Colors.black,
              //선택되지 않은 Tab 의 label 색상
              indicatorColor: Color(0xffCC2B2B),
              padding: EdgeInsets.only(left: 25, right: 25),
            ),
            Expanded(
              child: TabBarView(
                controller: _tc,
                children: [
                  MatchingLongTerm(
                    text: text,
                    id: widget.id,
                  ),
                  MatchingShortTerm(
                    text: text,
                    id: widget.id,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(bottom: 35, right: 15),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Color(0xffDE3425),
                onPressed: () async {
                  bool isBack = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => addMatchPage(
                                id: widget.id,
                              )));
                  if (isBack) {
                    setState(() {});
                  }
                },
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      //초기값
      firstDate: DateTime(2020),
      //시작일
      lastDate: DateTime(2023),
      //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) {
      _dateTime = dateTime;
      print(_dateTime);
    });
  }

  void showTimePickerPop() {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime.then((timeOfDay) {
      //선택한뒤의 행동
    });
  }
}

class addMatchPage extends StatefulWidget {
  const addMatchPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _AddMatchPage createState() => _AddMatchPage();
}

class _AddMatchPage extends State<addMatchPage> {
  ApiModel api = new ApiModel(
      'https://api.themoviedb.org/3/movie/now_playing?api_key=${apikey}&language=en-US&page=1');
  final peopleTextController = TextEditingController();
  final movieTextController = TextEditingController();
  String area = '서울';
  late Timestamp date;
  String movie = 'Black Adam';
  String chatName = '';
  String people = '';
  String term = '장기';
  String poster_path = '';
  DateTime _dateTime = DateTime.now();
  final List<String> areaList = ['서울', '인천', '수원', '대전', '대구', '광주', '부산'];
  final List<String> termList = ['장기', '단기'];

  //final List<String> movieList=['Black Adam','bbb'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('매칭 만들기',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: menuFont,
                  fontWeight: FontWeight.bold)),
          foregroundColor: Colors.black,
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: api.getJsonData(),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              } else {
                final List<String> movieList = [];
                final Map<String, String> movie_poster =
                    new Map<String, String>();
                for (int i = 0; i < 20; i++) {
                  movieList.add(snapshot.data[i]['original_title']);
                  movie_poster[snapshot.data[i]['original_title']] =
                      snapshot.data[i]['poster_path'];
                }
                return SingleChildScrollView(
                  child: Container(
                    width: 500,
                    height: 700,
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Color(0xffF3F3F3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "영화",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'jua',
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: DropdownButton(
                                    itemHeight: 70,
                                    isExpanded: true,
                                    value: movie,
                                    items: movieList.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        movie = value!;
                                      });
                                    },
                                  ),
                                  width: 140, //TextField 크기
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "지역",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'jua',
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: DropdownButton(
                                    value: area,
                                    items: areaList.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        area = value!;
                                      });
                                    },
                                  ),
                                  width: 60, //TextField 크기
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            new Text(
                              "날짜",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'jua',
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              child: OutlinedButton(
                                onPressed: () {
                                  showDatePickerPop();
                                },
                                child: Text(
                                  "날짜",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.black12,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),

                              width: 100, //TextField 크기
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 30,
                                ),
                                new Text(
                                  "인원",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'jua',
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  child: TextField(
                                    controller: peopleTextController,
                                    onChanged: (text) {
                                      people = text;
                                    },
                                  ),
                                  width: 100, //TextField 크기
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 30,
                                ),
                                new Text(
                                  "채팅방 이름",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'jua',
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  child: TextField(
                                    maxLines: 1,
                                    controller: movieTextController,
                                    onChanged: (text) {
                                      chatName = text;
                                    },
                                  ),
                                  width: 100, //TextField 크기
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            new Text(
                              "기간",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'jua',
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              child: DropdownButton(
                                value: term,
                                items: termList.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    term = value!;
                                  });
                                },
                              ),
                              width: 100, //TextField 크기
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffCC2B2B),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (people == '') {
                                    print("입력이 멀쩡 하지 않습니다.");
                                  } else {
                                    MatchModel inputData = new MatchModel(
                                      area: area,
                                      date: _dateTime,
                                      movieTitle: movie,
                                      needPeople: int.parse(people),
                                      userList: <String>[widget.id],
                                      chatName: chatName,
                                      poster_path: movie_poster[movie]!,
                                    );
                                    addMatchData(inputData, term == "장기");
                                    Navigator.pop(context, true);
                                  }
                                },
                                child: Text(
                                  "게시물 올리기",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: menuFont),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            }));
  }

  void addMatchData(MatchModel inputData, bool isLongTerm) async {
    String term = isLongTerm ? "longTerm" : "shortTerm";
    CollectionReference collection;
    if (isLongTerm) {
      collection = FirebaseFirestore.instance
          .collection('Match/Eiyq0InEtTTkJPieAflk/$term');
    } else {
      collection = FirebaseFirestore.instance
          .collection('Match/Eiyq0InEtTTkJPieAflk/$term');
    }

    //채팅방 생성
    DocumentReference df = await FirebaseFirestore.instance
        .collection('ChatRoom/rPDUIQvCg3PBVxuq3gR6/$term')
        .add({
      'recentMsg': "채팅방이 생성되었습니다.",
      'recentMsgTime': DateTime.now(),
      'roomTitle': inputData.chatName,
      'userList': inputData.userList,
    });
    String docid = df.id;

    //_createChat(docid);
    newChat().sendMessage(widget.id, "채팅방이 생성되었습니다.", term, docid);

    //add data
    collection.add({
      'chatRoomid': df.id,
      'area': inputData.area,
      'date': inputData.date,
      'movieTitle': inputData.movieTitle,
      'needPeople': inputData.needPeople,
      'currentPeople': 1,
      'userList': inputData.userList,
      'poster_path': inputData.poster_path,
    });
  }

  void _createChat(String id) async {
    final userData = await FirebaseFirestore.instance
        .collection('User')
        .doc(widget.id)
        .get();
    FirebaseFirestore.instance
        .collection('ChatRoom/rPDUIQvCg3PBVxuq3gR6/$term/$id/chat')
        .add({
      'id': widget.id,
      'text': "채팅방이 생성되었습니다.",
      'time': DateTime.now(),
      'name': userData.data()!['name'],
    });
  }

  void showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      //초기값
      firstDate: DateTime(2020),
      //시작일
      lastDate: DateTime(2023),
      //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) {
      _dateTime = dateTime!;
    });
  }
}
