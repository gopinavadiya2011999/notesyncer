import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesyncer/infrastructure/constant/app_constant.dart';
import 'package:notesyncer/infrastructure/constant/color_constant.dart';
import 'package:notesyncer/infrastructure/model/task_model.dart';
import 'package:notesyncer/ui/common_widgets/common_button.dart';
import 'package:notesyncer/ui/home/task_controller.dart';

void showTaskDialog({bool isEdit = false, Task? task}) {
  final TaskController controller = Get.find();

  final titleController = TextEditingController(text: task?.title ?? '');
  final descController = TextEditingController(text: task?.description ?? '');

  Get.defaultDialog(
    confirm: Obx(
      () => CommonButton(
        buttonText: isEdit ? AppConstant.update : AppConstant.add,
        isFilled: true,
        isLoading: controller.isUpdate.value, // <-- reactive now
        onTap: () async {
          controller.isUpdate.value = true;

          if (titleController.text.trim().isEmpty) {
            Get.snackbar(
              "Error",
              AppConstant.titleError,
              backgroundColor: ColorConstant.error,
              colorText: ColorConstant.white,
            );
            controller.isUpdate.value = false; // reset loading
            return;
          }

          final newTask = Task(
            id: task?.id ?? '',
            title: titleController.text.trim(),
            description: descController.text.trim(),
            updatedAt: DateTime.now(),
          );

          await controller.addOrUpdateTask(newTask);

          controller.isUpdate.value = false;
          titleController.clear();
          descController.clear();
          Get.back();
        },
      ),
    ),
    title: isEdit ? AppConstant.editTask : AppConstant.addTask,
    content: Column(
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: AppConstant.title),
        ),
        TextField(
          controller: descController,
          decoration: InputDecoration(labelText: AppConstant.desc),
        ),
      ],
    ),
    cancel: CommonButton(
      onTap: () => Get.back(),
      buttonText: AppConstant.cancel,
    ),
    barrierDismissible: false,
  );
}
