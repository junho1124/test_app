import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/view_model/bottom_nav_view_model.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavViewModel>(
        init: BottomNavViewModel(),
        builder: (vm) {
          return Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(-2, 0),
                  blurRadius: 1,
                )
              ], color: Colors.white),
              height: 60,
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () => vm.changePage(0),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: vm.canPop.isTrue
                              ? context.theme.primaryColor
                              : context.theme.disabledColor,
                        ),
                      ),
                      InkWell(
                        onTap: () => vm.changePage(1),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: vm.canGoNext.isTrue
                              ? context.theme.primaryColor
                              : context.theme.disabledColor,
                        ),
                      ),
                    ],
                  )));
        });
  }
}
