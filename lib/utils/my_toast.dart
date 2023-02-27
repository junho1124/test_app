import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToast {
  MyToast();

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black38,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.CENTER);
  }

  static void needLogin() {
    showToast("로그인이 필요한 서비스 입니다.");
  }
}
