class MatchModel { //aaa
  final String docID; //해당 도큐먼트의 ID를 담기위함.
  final String chatRoomid;
  final String movieTitle;
  final DateTime date;
  final int needPeople;
  final int currentPeople;
  final String area;
  final List<String> userList;
  final String chatName;
  final String poster_path;

  MatchModel({
    this.docID='',
    this.chatRoomid ='',
    this.movieTitle = '',
    required this.date,
    this.needPeople=0,
    this.currentPeople=0,
    this.area='',
    required this.userList,
    this.chatName='',
    this.poster_path='',
  });

  factory MatchModel.fromMap({required String id,required Map<String,dynamic> map}){
    return MatchModel(
      docID: id,
      chatRoomid: map['chatRoomid']??'',
      movieTitle: map['movieTitle']??'',
      date:map['date']??'',
      needPeople:map['needPeople']??'',
      currentPeople:map['currentPeople']??'',
      area:map['area']??'',
      userList: map['userList'],
    );
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> data = {};
    data['chatRoomid']=chatRoomid;
    data['movieTitle']=movieTitle;
    data['date']=date;
    data['needPeople']=needPeople;
    data['currentPeople']=currentPeople;
    data['area']=area;
    data['userList']=userList;
    return data;
  }
}