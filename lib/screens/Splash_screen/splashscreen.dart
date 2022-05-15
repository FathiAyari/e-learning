import 'dart:async';

import 'package:ahlem/screens/student/student_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../OnBoarding/on_boarding_page.dart';
import '../../pages/auth/signin.dart';
import '../../utils/constant.dart';
import '../admin/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var resultSeen = GetStorage().read("seen");
  var auth = GetStorage().read("auth");

  var type_auth = GetStorage().read("type_auth");
  @override
  void initState() {
    super.initState();
    var timer = Timer(
        Duration(seconds: 3),
        () => Get.to(resultSeen == 1
            ? (auth == 1
                ? (type_auth == 1 ? HomePageAdmin() : HomePageStudent())
                : LoginScreen())
            : OnBoardingPage()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: const BoxDecoration(),
            child: Column(children: <Widget>[
              SizedBox(
                height: size.height * 0.2,
              ),
              Image(
                image: AssetImage('assets/images/logo.png'),
                height: Constants.screenHeight * 0.1,
                width: Constants.screenWidth * 0.3,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                Constants.HomeText,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Lottie.asset("assets/images/educa.json",
                  height: Constants.screenHeight * 0.3),
              CircularProgressIndicator(),
            ])));
  }
}
