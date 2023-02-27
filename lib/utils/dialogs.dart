import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/app_theme.dart';

Future confirmDialog({
  required String title,
  required Widget content,
  String? confirm,
  String? cancel,
  bool choice = false,
  bool backWhenConfirm = true,
  bool barrierDismissible = false,
  required Function() onConfirm,
  Function()? onCancel,
}) async {
  await Get.defaultDialog(
      radius: 8,
      title: title,
      barrierDismissible: barrierDismissible,
      titleStyle: Get.textTheme.subtitle1,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
        child: content,
      ),
      confirm: Column(
        children: [
          InkWell(
              onTap: () async {
                if (backWhenConfirm) {
                  Get.back();
                }
                await onConfirm();
                if (!backWhenConfirm) {
                  Get.back();
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppTheme.mainColor),
                child: Center(
                    child: Text(
                  confirm ?? "확인",
                  style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
                )),
              )),
          AppTheme.spaceHeight8,
          InkWell(
              onTap: () async {
                await onCancel?.call();
                Get.back();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: choice ? AppTheme.mainColor : AppTheme.buttonGrey),
                child: Center(
                    child: Text(
                  cancel ?? "취소",
                  style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
                )),
              ))
        ],
      ));
}

Future simpleDialog({
  required String title,
  required Widget contents,
  String confirmText = "확인",
  bool barrierDismissible = false,
  VoidCallback? onConfirm,
}) async {
  await Get.defaultDialog(
    title: title,
    content: contents,
    barrierDismissible: barrierDismissible,
    textConfirm: confirmText,
    onConfirm: () => onConfirm == null ? Get.back() : onConfirm.call(),
    buttonColor: AppTheme.mainColor,
    confirmTextColor: Colors.white,
  );
}
