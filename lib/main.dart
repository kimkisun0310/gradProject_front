import 'package:flutter/material.dart';
import 'package:grad_ffront/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:grad_ffront/model/login_id.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picture_With',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogInSignUpScreen(),
    );
  }
}
