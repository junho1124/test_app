import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/view/main_page/main_page.dart';
import 'package:test_app/presentation/view_model/bottom_nav_view_model.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavViewModel>(
        init: BottomNavViewModel(),
        builder: (vm) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: const MainPage(),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) => vm.changePage(index),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_back_ios_new), label: "Previous"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_forward_ios), label: "Next")
                ]),
          );
        });
  }
}
