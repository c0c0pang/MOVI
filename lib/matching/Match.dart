import 'package:flutter/material.dart'; //aaa
import 'package:intl/intl.dart';
import './MatchingLongTerm.dart';
import 'MatchingShortTerm.dart';
import 'package:moviproject/models/matchModel.dart';

const menuFont = 'NanumSquareRound';

class MATCH extends StatefulWidget {
  const MATCH({super.key});

  @override
  State<MATCH> createState() => mainMatchPage();
}

class mainMatchPage extends State<MATCH> with TickerProviderStateMixin {
  late TabController _tc;
  DateTime? _dateTime = DateTime.now();

  @override
  void initState() {
    _tc = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  List<MatchModel> longData = <MatchModel>[
    MatchModel(
      movieTitle: "장기영화 제목1",
      date: "1/30",
      needPeople: 6,
      currentPeople: 1,
      area: "서울",
      longTerm: true,
    ),
    MatchModel(
      movieTitle: "장기영화 제목2",
      date: "2/28",
      needPeople: 4,
      currentPeople: 1,
      area: "대전",
      longTerm: true,
    ),
    MatchModel(
      movieTitle: "장기영화 제목3",
      date: "3/16",
      needPeople: 4,
      currentPeople: 1,
      area: "부산",
      longTerm: true,
    ),
    MatchModel(
      movieTitle: "장기영화 제목4",
      date: "4/1",
      needPeople: 6,
      currentPeople: 1,
      area: "대구",
      longTerm: true,
    ),
    MatchModel(
      movieTitle: "장기영화 제목5",
      date: "5/15",
      needPeople: 3,
      currentPeople: 1,
      area: "서울",
      longTerm: true,
    ),
  ];
  List<MatchModel> shortData = <MatchModel>[
    MatchModel(
      movieTitle: "영화 제목1",
      date: "11/20",
      needPeople: 4,
      currentPeople: 1,
      area: "서울",
    ),
    MatchModel(
      movieTitle: "영화 제목2",
      date: "11/20",
      needPeople: 4,
      currentPeople: 1,
      area: "대전",
    ),
    MatchModel(
      movieTitle: "영화 제목3",
      date: "11/20",
      needPeople: 4,
      currentPeople: 1,
      area: "부산",
    ),
    MatchModel(
      movieTitle: "영화 제목4",
      date: "11/20",
      needPeople: 6,
      currentPeople: 1,
      area: "강릉",
    ),
    MatchModel(
      movieTitle: "영화 제목5",
      date: "11/20",
      needPeople: 3,
      currentPeople: 1,
      area: "서울",
    ),
  ];

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
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              border:
                              Border.all(width: 1, color: Colors.black12)),
                          child: Row(children: <Widget>[
                            Flexible(
                              child: Container(
                                child: TextField(
                                  controller: _tec,
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '게시물 제목, 내용, 작성자 검색',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      )),
                                  cursorColor: Colors.black12,
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
                Text('장기모임', style: TextStyle(fontSize: 18)),
                Text('단기모임', style: TextStyle(fontSize: 18)),
              ],
              labelColor: Colors.black,
              //선택된 Tab 의 label 색상
              unselectedLabelColor: Colors.black,
              //선택되지 않은 Tab 의 label 색상
              indicatorColor: Color(0xffCC2B2B),
            ),
            Expanded(
              child: TabBarView(
                controller: _tc,
                children: [
                  MatchingLongTerm(inputData: longData),
                  MatchingShortTerm(inputData: shortData),
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
                          builder: (context) =>
                              addMatchPage(
                                  iLongData: longData, iShortData: shortData)));
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
  const addMatchPage(
      {Key? key, required this.iLongData, required this.iShortData})
      : super(key: key);
  final List<MatchModel> iLongData;
  final List<MatchModel> iShortData;

  @override
  _AddMatchPage createState() => _AddMatchPage();
}

class _AddMatchPage extends State<addMatchPage> {
  final peopleTextController = TextEditingController();
  final movieTextController = TextEditingController();
  String? area = '서울';
  String date = '';
  String people = '';
  String? term = '장기';
  String? movie = 'Black Adam';
  DateTime _dateTime = DateTime.now();
  final List<String> areaList = ['서울', '인천', '수원', '대전', '대구', '광주', '부산'];
  final List<String> termList = ['장기', '단기'];
  final List<String> movieList = [
    'Black Adam',
    'Woman King',
    'R.I.P.D. 2: Rise of the Damned',
    'Paradise City'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('매칭 만들기',style: TextStyle(color: Colors.black,fontSize: 25,fontFamily: menuFont,fontWeight: FontWeight.bold)),
        foregroundColor: Colors.black,
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: SingleChildScrollView(
        child: Container(
            width: 500,
            height: 700,
            padding: EdgeInsets.all(50),
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(
                  Radius.circular(70),
                )),
            child: Expanded(
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
                              "지역",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'jua',
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              child: Flexible(
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
                                        area = value;
                                      });
                                    },
                                  )),
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
                          "날짜",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'jua',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          child: Flexible(
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
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                              ),
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
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              child: new Flexible(
                                child: new TextField(
                                  controller: peopleTextController,
                                  onChanged: (text) {
                                    people = text;
                                  },
                                ),
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
                              "영화",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'jua',
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              child: new Flexible(
                                child: new TextField(
                                  controller: movieTextController,
                                  onChanged: (text) {
                                    people = text;
                                  },
                                ),
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
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          child: Flexible(
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
                                    term = value;
                                  });
                                },
                              )),
                          width: 100, //TextField 크기
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                              color: Colors.white54,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (people == '') {
                                    print("입력이 멀쩡 하지 않습니다.");
                                  } else {
                                    if (term == "장기") {
                                      widget.iLongData.add(
                                        MatchModel(
                                            movieTitle: movie!,
                                            date: DateFormat('MM/dd').format(
                                                _dateTime),
                                            needPeople: int.parse(people),
                                            currentPeople: 1,
                                            area: area!),
                                      );
                                    } else {
                                      widget.iShortData.add(MatchModel(
                                          movieTitle: movie!,
                                          date: DateFormat('MM/dd').format(
                                              _dateTime),
                                          needPeople: int.parse(people),
                                          currentPeople: 1,
                                          area: area!));
                                    }
                                    Navigator.pop(context, true);
                                  }
                                },

                                child: Text(
                                  "게시물 올리기",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                ))),
      )

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
      _dateTime = dateTime!;
      //print(_dateTime);
    });
  }
}
