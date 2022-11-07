class Post{
  int authorId;
  String title;
  String contents;
  int price;

  Post(this.authorId, this.title, this.contents, this.price);

  Map<String, dynamic>toJson()=>{
    'title' : title,
    'contents' : contents,
    'price' : price,
    'authorId' : authorId
  };
}