import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grad_ffront/config/palette.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_ffront/model/login_id.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grad_ffront/model/post.dart';
import 'package:grad_ffront/controller/api.dart';
import 'package:get/get.dart';

class PostWrite extends StatefulWidget {
  const PostWrite({Key? key}) : super(key: key);
  @override
  State<PostWrite> createState() => _PostWriteState();
}

class _PostWriteState extends State<PostWrite> {
  var titleController = TextEditingController();
  var contentsController = TextEditingController();
  var priceController = TextEditingController();

  Map<String,String> headers = {'Content-Type':'application/json'};

  submitPost() async{
    Post postModel = Post(
      Get.find<LogInId>().loginId,
      titleController.text.trim(),
      contentsController.text.trim(),
      int.parse(priceController.text.trim())
    );
    try{
      var response = await http.post(
          Uri.parse(API.postconnect),
          headers: headers,
          body : jsonEncode(postModel.toJson())
      );
      if(response.statusCode==200) {
        Navigator.pop(context);
      }
      else Fluttertoast.showToast(msg: 'Submit failed. Please try again.');
    }catch(e){
      Fluttertoast.showToast(msg: 'Submit failed. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('게시물 작성'),),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  height: 50,
                  child: TextField(
                    minLines: 2,
                    maxLines: 5,
                    controller: titleController,
                    decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.textColor1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      hintText: '제목',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Palette.textColor1,
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 300,
                  child: TextField(
                    minLines: 20,
                    maxLines: 20,
                    controller: contentsController,
                    decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.textColor1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      hintText: '내용',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Palette.textColor1,
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                  controller: priceController,
                  decoration: InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.textColor1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    hintText: '가격',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Palette.textColor1,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      submitPost();
                    },
                    child: Container(
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
