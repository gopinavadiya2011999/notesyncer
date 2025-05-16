import 'package:flutter/material.dart';
import 'package:notesyncer/infrastructure/constant/date_constant.dart';
import '../../infrastructure/constant/color_constant.dart';
import '../../infrastructure/model/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onEdit,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
            color: ColorConstant.black.withAlpha(10),
              blurRadius: 8,
              spreadRadius: 5,
              offset: Offset(0, 3)
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.black,
                    ),
                  ),
                  if(task.description.isNotEmpty)
                    Text(task.description)
                ],
              ),
            ),
            Text(
              DateConstant.formatDateTime(task.updatedAt)
              ,style: TextStyle(fontSize: 12, color: ColorConstant.accent),
            ),
            SizedBox(width: 5),
            InkWell(
                radius: 0,
                onTap: onDelete,
                child: Icon(Icons.delete,color: ColorConstant.error,))
          ],

        ),
      ),
    );
  }
}
