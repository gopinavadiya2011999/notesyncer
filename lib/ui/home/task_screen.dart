import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesyncer/infrastructure/constant/app_constant.dart';
import 'package:notesyncer/ui/home/popups/add_edit_popup.dart';
import 'package:notesyncer/ui/home/popups/delete_task_popup.dart';
import '../../infrastructure/constant/color_constant.dart';
import '../../ui/common_widgets/task_tile.dart';
import 'task_controller.dart';

class TaskScreen extends StatelessWidget {
  final TaskController controller = Get.find();

  TaskScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.background,
      appBar: AppBar(
        title: Obx(() => Text(
            controller.isOnline.value ? AppConstant.onlineTask : AppConstant.offlineTask,style: TextStyle(
          color: ColorConstant.white
        ),)),
        backgroundColor: ColorConstant.primary,
        actions: [
          Obx(() => controller.isSyncing.value
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Transform.scale(
              scale: 0.5,
              child: CircularProgressIndicator(
                color: ColorConstant.white,
              ),
            ),
          )
              : SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        if (controller.tasks.isEmpty) {
          return Center(child: Text(AppConstant.noTaskFound));
        }
        return ListView.separated(
          padding: EdgeInsets.all(16),
          itemCount: controller.tasks.length,
          separatorBuilder: (_, __) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            final task = controller.tasks[index];
            return TaskTile(
              task: task,
              onDelete:() => showDeleteTaskDialog(() {
                 controller.deleteTask(task.id);
                Get.back();
              }),
              onEdit: () => showTaskDialog(isEdit: true, task: task),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstant.primary,
        onPressed: () => showTaskDialog(),
        child: Icon(Icons.add, color: ColorConstant.white),
      ),
    );
  }
}
