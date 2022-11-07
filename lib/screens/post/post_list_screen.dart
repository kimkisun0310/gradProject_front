import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grad_ffront/screens/post/post_screen.dart';
import 'package:http/http.dart' as http;
import 'package:grad_ffront/controller/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_ffront/screens/post/post_write_screen.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);
  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  var responseBody;
  String? title;
  String? authorName;
  int? postId;

  @override
  void initState() {
    super.initState();
  }

  var my_list = ['사진 찍어주실분 계신가요? 홍대 앞입니다.', '신촌 빨간 잠망경 앞인데 2명 사진교환해요.', '오늘 축구부 운동 끝나고 단체사진 찍어주실분. 계십니까,', '친구랑 있는데 인스타용 사진 찍어주실분 평점 봅니다.',
  '사진교환하실분 계신가여 잘찍으시는 분만'];

  getPosts() async{
    try{
      print('debug1');
      var response = await http.get(
        Uri.parse(API.postconnect),
      );
      if(response.statusCode == 200){
        responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      }
      else{
        Fluttertoast.showToast(msg: 'Connected Failed. Please try again');
      }
    }catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: 'Error Occured. Please try again.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: getPosts(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              itemCount: responseBody['data'].length,
              itemBuilder: (BuildContext context, int index) {
                title = responseBody['data'][index]['title'];
                authorName = responseBody['data'][index]['authorName'];
                postId = responseBody['data'][index]['postId'];
                return new GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return PostScreen(responseBody['data'][index]['postId']);
                      })
                    );
                  },
                  child: new Card(
                    child: new Row(
                      children: [
                        new SizedBox(
                          width: 100,
                          height: 100,
                          child: new Container(
                            padding: EdgeInsets.all(12),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: (index < 5) ?
                                    AssetImage("assets/images/pic${index + 1}.png")
                                  : AssetImage('assets/images/person.jpg'),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        new SizedBox(width: 20,),
                        new Flexible(
                          child: new Text(
                            '${title}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        new SizedBox(width: 20,),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return PostWrite();
            })
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}