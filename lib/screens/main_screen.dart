import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_ffront/screens/login_screen.dart';
import 'chat/my_chat_list_screen.dart';
import 'post/post_list_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _WidgetOptions = <Widget>[
    PostList(),
    MyChatList(),
    MyProfile()
  ];

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  void logout(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Text('정말 로그아웃 하시겠습니까?'),
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                    builder: (context) => LogInSignUpScreen()
                ),
                    (_) => false,
              );
            }, child: Text('Yes', style: TextStyle(fontWeight: FontWeight.bold),)),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child:Text('Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Picture with'),
        actions: [
          ElevatedButton(
              onPressed: (){
                logout(context);
              },
              child: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: _WidgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label:'게시글',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '내 정보',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
