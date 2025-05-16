import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'infrastructure/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

import 'infrastructure/routes/route_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Offline-First Tasks',
      initialRoute: RouteConstants.task,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
