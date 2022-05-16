import 'package:ahlem/screens/admin/fonctionalite.dart';
import 'package:ahlem/screens/admin/gerer_course/list_course.dart';
import 'package:ahlem/screens/admin/gerer_uti/home_page.dart';
import 'package:ahlem/screens/admin/update_student_page.dart';
import 'package:ahlem/screens/student/student_home_page.dart';
import 'package:ahlem/services/remember_controller.dart';
import 'package:ahlem/utils/constant.dart';
import 'package:flutter/material.dart';

import 'add_student_page.dart';
import 'list_student_page.dart';

class HomePageAdmin extends StatefulWidget {
  HomePageAdmin({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageAdmin> {
  RememberController rememberController = RememberController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blueAccent),
        ),
        body: ListStudentPage(),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: Constants.screenHeight * 0.07,
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("are you sure you wanna log out??"),
                                actions: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.redAccent.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("NO"))),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blueAccent,
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            rememberController.Logout();
                                          },
                                          child: Text(
                                            "yes",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                ],
                              );
                            });
                      },
                      child: Text("Log out"))),
            ],
          ),
        ),
      ),
    );
  }
}
