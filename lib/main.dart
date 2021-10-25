import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import 'app/firebase_options.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetxFire.init(
    name: 'event_loc',
    options: firebaseOptions
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
