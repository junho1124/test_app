import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:test_app/core/app_route.dart';
import 'package:test_app/utils/hive_service.dart';
import 'package:test_app/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Log.init();
  await HiveService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      onGenerateRoute: (settings) => AppRoutes.onGenerateRoutes(settings),
      navigatorKey: Get.key,
      navigatorObservers: [
        NavigationHistoryObserver(),
      ],
    );
  }
}
