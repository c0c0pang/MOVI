import 'package:flutter/material.dart';
const baseApi = 'https://image.tmdb.org/t/p/original';
class POSTER_SCREEN extends StatefulWidget {
  // const POSTER_SCREEN({Key? key}) : super(key: key);
  POSTER_SCREEN({this.parserPosterData});
  final parserPosterData;
  @override
  State<POSTER_SCREEN> createState() => _POSTER_SCREENState();
}

class _POSTER_SCREENState extends State<POSTER_SCREEN> {
  String? poster;
  String? title;
  double? popularity;
  @override
  void initState() {
  super.initState();
  updateData(widget.parserPosterData);
  print(widget.parserPosterData);
  }
  void updateData(Data){
    poster = Data[0]['poster_path'];
    title = Data[0]['title'];
    popularity = Data[0]['popularity'];
  }
  Widget build(BuildContext context) {
    return Container(
      child: Image.network('${baseApi}${poster}'),
    );
  }
}
