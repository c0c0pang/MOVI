import 'package:flutter/material.dart'; //aaa
import 'package:moviproject/models/matchModel.dart';

class MatchingLongTerm extends StatefulWidget {
  const MatchingLongTerm({Key? key}) : super(key: key);

  @override
  State<MatchingLongTerm> createState() => LongTermState();
}

class LongTermState extends State<MatchingLongTerm>{
  List<MatchModel> data=<MatchModel>[
    MatchModel(
      movieTitle: "영화 제목1",
      date: "11/20",
      needPeople:4,
      currentPeople:1,
      area:"서울",
    ),
    MatchModel(
      movieTitle: "영화 제목2",
      date: "11/20",
      needPeople:4,
      currentPeople:1,
      area:"대전",
    ),
    MatchModel(
      movieTitle: "영화 제목3",
      date: "11/20",
      needPeople:4,
      currentPeople:1,
      area:"부산",
    ),
    MatchModel(
      movieTitle: "영화 제목4",
      date: "11/20",
      needPeople:6,
      currentPeople:1,
      area:"강릉",
    ),
    MatchModel(
      movieTitle: "영화 제목5",
      date: "11/20",
      needPeople:3,
      currentPeople:1,
      area:"서울",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return print(context);
  }

  Widget print(BuildContext context){
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: data.length,
      itemBuilder: (context,int index){
        return Row(
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.lightBlue,
              ),
              Expanded(
                  child: Container(
                    width: 380,
                    height: 200,
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data[index].movieTitle,
                          style: TextStyle(fontSize: 30),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('날짜',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(data[index].date,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('모집인원',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text('${data[index].currentPeople}/${data[index].needPeople}',
                              style: TextStyle(fontSize: 20),)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('지역',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(data[index].area,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
              )

            ]
        );
      },
      separatorBuilder: (context, int index)=>const Divider(
        height: 10.0,
      ),
    );
  }
}
