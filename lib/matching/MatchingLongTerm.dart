import 'package:flutter/material.dart'; //aaa
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moviproject/models/matchModel.dart';

class MatchingLongTerm extends StatefulWidget {
  const MatchingLongTerm({Key? key,required this.inputData}) : super(key: key);
  final List<MatchModel> inputData;
  @override
  State<MatchingLongTerm> createState() => LongTermState();
}

class LongTermState extends State<MatchingLongTerm>{
  int selectIndex=-1;
  List<MatchModel> data=[];
  @override
  Widget build(BuildContext context){
    data=widget.inputData;
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: data.length,
      itemBuilder: (context,int index){
        return Row(
          children: [
            Expanded(
                child: Container(
                    child: ListTile(

                      title: Container(
                        child: Text(data[index].movieTitle,
                          style: TextStyle(fontSize: 23),
                        ),
                      ),
                      subtitle: Container(
                        child: Column(
                          //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('날짜',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(data[index].date,
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('모집인원',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text('${data[index].currentPeople}/${data[index].needPeople}',
                                    style: TextStyle(fontSize: 17),)
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('지역',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(data[index].area,
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        selectIndex=index;
                        showModalBottomSheet(context: context, builder: buildBottomSheet);
                      },
                    )
                )
            )
          ],
        );
      },
      separatorBuilder: (context, int index)=>const Divider(
        height: 10.0,
      ),
    );
  }


  Widget buildBottomSheet(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Container(
                child:Text("해당 매칭에 참가하시겠습니까?")
            ),

            OutlinedButton(
                onPressed: (){
                  setState(() {
                    joinMessage();
                    data.removeAt(selectIndex);
                    Navigator.pop(context);
                  });
                },
                child: Text("예"),
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    )
                )),
          ],
        )
    );
  }

  void joinMessage(){
    Fluttertoast.showToast(
      msg: "참가되었습니다.",
      gravity: ToastGravity.BOTTOM,
    );
  }
}
