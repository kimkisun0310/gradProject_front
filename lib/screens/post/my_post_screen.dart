import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grad_ffront/model/login_id.dart';

class MyPost extends StatefulWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {

  var my_list = ['사진 찍어주실분 계신가요? 홍대 앞입니다.'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 게시물 목록'),),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            // title = responseBody['data'][0]['title'];
            // authorName = responseBody['data'][0]['authorName'];
            // postId = responseBody['data'][0]['postId'];
            return GestureDetector(
              onTap: () {
                print("${Get.find<LogInId>().loginId}");
              },
              child: Card(
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: CircleAvatar(
                          radius: 60,
                          // backgroundImage: AssetImage('assets/images/blue.jpg'),
                          backgroundImage: AssetImage("assets/images/pic${index+1}.png"),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Flexible(
                      child:
                      Text(
                        '${my_list[index]}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}
