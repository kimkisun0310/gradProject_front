import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grad_ffront/config/palette.dart';
import 'package:grad_ffront/model/login_id.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../model/member.dart';
import 'main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:grad_ffront/controller/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';


class LogInSignUpScreen extends StatefulWidget {
  const LogInSignUpScreen({Key? key}) : super(key: key);

  @override
  State<LogInSignUpScreen> createState() => _LogInSignUpScreenState();
}

class _LogInSignUpScreenState extends State<LogInSignUpScreen> {
  bool isLogInScreen = true;
  bool showSpinner = false;


  var memberNameController = TextEditingController();
  var memberEmailController = TextEditingController();
  var passwordController = TextEditingController();
  var logInEmailController = TextEditingController();
  var logInPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Map<String,String> headers = {'Content-Type':'application/json'};

  setLogInId(int id){
    LogInId logInIdcontroller = Get.put(LogInId());
    logInIdcontroller.setId(id);
  }

  changePassword(String password){
    var bytesToHash = utf8.encode(password);
    var md5Digest = md5.convert(bytesToHash);
    return md5Digest.toString();
  }

  checkMemberEmail() async{
    String email = memberEmailController.text.trim();
    try{
      var response = await http.get(
        Uri.parse(API.validateMember + email),
      );
      if(response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        print(responseBody['data']);
        if(responseBody['data'] != -1) Fluttertoast.showToast(msg: 'Email is already in use. Please try another email.');
        else saveInfo();
      }
      else{
        Fluttertoast.showToast(msg: 'Error occurred. Please try again');
      }
    }catch(e){}
  }

  saveInfo() async{
    Member memberModel = Member(
      memberNameController.text.trim(),
      memberEmailController.text.trim(),
      changePassword(passwordController.text.trim())
    );
    try{
      var response = await http.post(
        Uri.parse(API.memberconnect),
        headers: headers,
        body: jsonEncode(memberModel.toJson())
      );
      if(response.statusCode==200){
        var responseBody = jsonDecode(response.body);
        if(responseBody['data']!=-1) Fluttertoast.showToast(msg: 'SignUp Succeed');
        else Fluttertoast.showToast(msg: 'Error occurred. Please try again');
      }
      else Fluttertoast.showToast(msg: 'Error occurred. Please try again');
    }
    catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  login() async {
    Member memberModel = Member.login(
      logInEmailController.text.trim(),
      changePassword(logInPasswordController.text.trim())
    );
    try{
      var response = await http.post(
        Uri.parse(API.memberlogin),
        headers: headers,
        body : jsonEncode(memberModel.toLogIn())
      );
      if(response.statusCode==200){
        var responseBody = jsonDecode(response.body);
        var memberId = responseBody['data'];
        if(memberId!=-1) {
          setLogInId(memberId);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) {
                    return MainScreen();
                  }
              )
          );
        }
        else Fluttertoast.showToast(msg: 'login failed. Please check your email and password.');
      }
      else Fluttertoast.showToast(msg: 'login failed. Please check your email and password.');
    }catch(e){
      Fluttertoast.showToast(msg: 'login failed. Please check your email and password.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/blue.jpg'),
                      fit: BoxFit.fill
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 90, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Picture With',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                curve: Curves.easeIn,
                top: 180,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeIn,
                  padding: EdgeInsets.all(20.0),
                  height: isLogInScreen ? 280 : 320,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState((){
                                  isLogInScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isLogInScreen ? Colors.orange : Colors.grey[300],
                                    ),
                                  ),
                                  if(isLogInScreen)
                                    Container(
                                      margin: EdgeInsets.only(top : 3),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState((){
                                  isLogInScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isLogInScreen ? Colors.orange : Colors.grey[300],
                                    ),
                                  ),
                                  if(!isLogInScreen)
                                    Container(
                                      margin: EdgeInsets.only(top:3),
                                      height: 2,
                                      width: 70,
                                      color: Colors.orange,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        if(isLogInScreen)
                          Material(
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: logInEmailController,
                                      key: ValueKey(1),
                                      validator: (value){
                                        if(value!.isEmpty || !value.contains('@')){
                                          return 'Please enter a valid email address.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Palette.textColor1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    TextFormField(
                                      controller: logInPasswordController,
                                      obscureText: true,
                                      key: ValueKey(2),
                                      validator: (value){
                                        if(value!.isEmpty || value.length<6){
                                          return 'Please enter at least 6 characters';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Palette.textColor1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if(!isLogInScreen)
                          Material(
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: memberNameController,
                                      key: ValueKey(3),
                                      validator: (value){
                                        if(value!.isEmpty || value.length < 4){
                                          return 'Please enter at least 4 characters.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_circle,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Palette.textColor1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        hintText: 'Name',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    TextFormField(
                                      controller: memberEmailController,
                                      key: ValueKey(4),
                                      validator: (value){
                                        if(value!.isEmpty || !value.contains('@')){
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Palette.textColor1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      key: ValueKey(5),
                                      validator: (value){
                                        if(value!.isEmpty || value.length<6){
                                          return 'Please enter at least 6 characters.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Palette.textColor1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),

                  ),
                ),


              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isLogInScreen ? 390 : 430,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if(isLogInScreen)
                          login();
                        else {
                          checkMemberEmail();
                        }
                        setState((){
                          showSpinner = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0,1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
