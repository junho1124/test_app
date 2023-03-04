import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/domain/entities/login_input.dart';
import 'package:test_app/presentation/view/main_page/main_page.dart';
import 'package:test_app/utils/dialogs.dart';
import 'package:test_app/utils/logger.dart';

import '../../data/repository/user_auth_repository.dart';

class LoginViewModel extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    emailController.text = "john@gmail.com";
    passwordController.text = "qwer1234";
    super.onInit();
  }

  final _userAuthRepository = UserAuthRepository();

  Future login() async {
    if(!emailController.text.isNotEmpty || !passwordController.text.isNotEmpty) {
      simpleDialog(title: "로그인 에러", contents: Text("로그인 정보를 입력 해 주세요"));
    }
    final result = await _userAuthRepository.login(LoginInput(
        email: emailController.text, password: passwordController.text));
    result.when(success: (user) {
      Log.d(user);
      Get.offAllNamed(MainPage.path);
    }, error: (e) {
      simpleDialog(title: "로그인 실패", contents: Text(e.toString()));
    });
  }
}
