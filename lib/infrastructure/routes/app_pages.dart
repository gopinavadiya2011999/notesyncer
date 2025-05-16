import 'package:get/get.dart';
import 'package:notesyncer/ui/home/task_binding.dart';
import 'package:notesyncer/ui/home/task_screen.dart';
import 'route_constants.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: RouteConstants.task,
      page: () =>  TaskScreen(),
      binding: TaskBinding(),
    ),
  ];
}
