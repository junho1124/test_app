import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/view_model/login_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String path = "/";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginViewModel>(
        init: LoginViewModel(),
        builder: (vm) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("로그인"),
              centerTitle: true,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  buildTextBox(context, vm.emailController, "email"),
                  const SizedBox(height: 8),
                  buildTextBox(context, vm.passwordController, "password"),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => vm.login(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.theme.primaryColor),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        "로그인",
                        style: context.textTheme.bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Container buildTextBox(
      BuildContext context, TextEditingController controller, String hint) {
    return Container(
      width: context.width,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.black12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
        obscureText: hint == "password",
      ),
    );
  }
}
