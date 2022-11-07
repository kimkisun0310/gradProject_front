import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInId extends GetxController{
  int _loginId = -1;
  int get loginId => _loginId;

  void setId(int id){
    _loginId = id;
    update();
  }
}