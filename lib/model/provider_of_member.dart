import 'package:flutter/material.dart';

class LogInId with ChangeNotifier{
  int? _memberId;
  int? get memberId => _memberId;

  void setId(int id){
    _memberId = id;
    notifyListeners();
  }
}