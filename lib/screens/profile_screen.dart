import 'package:flutter/material.dart';
import 'package:grad_ffront/add_image/add_image.dart';
import 'package:grad_ffront/screens/post/my_post_screen.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  void showAlert(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            backgroundColor: Colors.white,
            child: AddImage()
          );
        },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  showAlert(context);
                },
                child: SizedBox(
                  width: 140,
                  height: 140,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: CircleAvatar(
                      radius: 60,
                      // backgroundImage: AssetImage('assets/images/blue.jpg'),
                      backgroundImage: AssetImage("assets/images/pic1.png"),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40,),
              Column(
                children: [
                  SizedBox(height: 10,),
                  Text(
                    '이름 : Rachel'
                    '\n\n'
                    '인기도 : 15',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 30,),
          ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return MyPost();
                  })
                );
              },
              child: SizedBox(
                height: 30,
                width: 300,
                child: Text(
                  '내 게시물 보기',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
          ),
        ],
      ),
    );
  }
}
