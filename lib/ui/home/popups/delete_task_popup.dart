import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesyncer/infrastructure/constant/app_constant.dart';
import 'package:notesyncer/ui/common_widgets/common_button.dart';

void showDeleteTaskDialog(GestureTapCallback onTap) {


  Get.defaultDialog(
    title: AppConstant.deleteTask,
    titleStyle: const TextStyle(fontWeight: FontWeight.bold),
    content:  Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        AppConstant.warningText,
        textAlign: TextAlign.center,
      ),
    ),
    confirm: CommonButton(
      buttonText: AppConstant.delete,
      isFilled: true,
      onTap: onTap,
    ),
    cancel: CommonButton(
      buttonText: AppConstant.cancel,
      onTap: () => Get.back(),
    ),
    barrierDismissible: false,
  );
}
