class Post{
  String key;
  String title;
  String explain;
  int like;
  int reply;
  Post({
    @required this.key,
    this.title,
    this.explain,
    this.like,
    this.reply
});
}