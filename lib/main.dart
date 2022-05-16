import 'package:ahlem/screens/Splash_screen/splashscreen.dart';
import 'package:ahlem/screens/student/components/courses/coursePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await FlutterDownloader.initialize(debug: true);
  WidgetsFlutterBinding.ensureInitialized(); //
  await Firebase.initializeApp(); //
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/coursePage': (context) => CoursePage(),
        },
        title: 'Educa ',
        home: SplashScreen());
  }
}
