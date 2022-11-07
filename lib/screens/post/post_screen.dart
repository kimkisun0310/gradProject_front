import 'package:flutter/material.dart';
import 'package:grad_ffront/controller/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class PostScreen extends StatefulWidget {
  PostScreen(this.postId, {Key? key}) : super(key: key);
  final int postId;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var responseBody;
  String? title;
  String? contents;
  int? price;
  String? authorName;
  String? picURL;
  String url='';

  void initState(){
    url = API.postconnect +"/"+ (widget.postId).toString();
    print(url);
    super.initState();
  }

  getPost() async{
    try{
      var response = await http.get(
        Uri.parse(url),
      );
      if(response.statusCode == 200){
        responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        title = responseBody['data']['title'];
        contents = responseBody['data']['contents'];
        price = responseBody['data']['price'];
        authorName = responseBody['data']['authorName'];
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
        future: getPost(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(),
              body: Container(
                child: Column(
                  children: [
                    Text('${title}'),
                    SizedBox(height: 10,),
                    Text('${contents}'),

                  ],
                ),
              ),
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
