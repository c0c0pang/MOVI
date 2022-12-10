import 'package:flutter/material.dart'; //aaa
import 'package:moviproject/models/matchModel.dart';
class MatchingShortTerm extends StatefulWidget {
  const MatchingShortTerm({Key? key}) : super(key: key);

  @override
  State<MatchingShortTerm> createState() => ShortTermState();
}

class ShortTermState extends State<MatchingShortTerm>{
  List<MatchModel> data=<MatchModel>[
    MatchModel(
      movieTitle: "장기영화 제목1",
      date: "1/30",
      needPeople:6,
      currentPeople:1,
      area:"서울",
    ),
    MatchModel(
      movieTitle: "장기영화 제목2",
      date: "2/28",
      needPeople:4,
      currentPeople:1,
      area:"대전",
    ),
    MatchModel(
      movieTitle: "장기영화 제목3",
      date: "3/16",
      needPeople:4,
      currentPeople:1,
      area:"부산",
    ),
    MatchModel(
      movieTitle: "장기영화 제목4",
      date: "4/1",
      needPeople:6,
      currentPeople:1,
      area:"강릉",
    ),
    MatchModel(
      movieTitle: "장기영화 제목5",
      date: "5/15",
      needPeople:3,
      currentPeople:1,
      area:"서울",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<MatchModel> outputData=data;
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: outputData.length,
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
                        Text(outputData[index].movieTitle,
                          style: TextStyle(fontSize: 30),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('날짜',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(outputData[index].date,
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
                            Text('${outputData[index].currentPeople}/${outputData[index].needPeople}',
                              style: TextStyle(fontSize: 20),)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('지역',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(outputData[index].area,
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