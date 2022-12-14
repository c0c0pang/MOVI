class MatchModel { //aaa
  final String id; //해당 도큐먼트의 ID를 담기위함.
  final String movieTitle;
  final String date;
  final int needPeople;
  final int currentPeople;
  final String area;
  final bool longTerm;

  MatchModel({
    this.id = '',
    this.movieTitle = '',
    this.date='',
    this.needPeople=0,
    this.currentPeople=0,
    this.area='',
    this.longTerm=true,
  });


}