// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gerer_course/home_course.dart';
import 'gerer_uti/home_page.dart';

class FonctionaliteAdmin extends StatelessWidget {
  const FonctionaliteAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color2 = Color(0xffff5954);
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.grey,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //lektiba  lkol f center
          children: [
            Row(
              //hedhy ligne loula fiha titre WELCOME TO EDUCA
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 6,
                ),
                Text(
                  ' Hi Admin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            //  SvgPicture.asset("assets/icons/educate.svg", height: 90,),
            // const SizedBox(height:16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: CupertinoButton(
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    color: color2,
                    onPressed: (() {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => HomePage()));
                    }),
                    child: const Text(
                      'Gestion des utlisateurs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 246, 241, 243),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: CupertinoButton(
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    color: Color(0xffff5954),
                    onPressed: (() {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => HomeCourse()));
                    }),
                    child: const Text(
                      "Gestion des cours ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: CupertinoButton(
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    color: Color(0xffff5954),
                    onPressed: (() {
                      // Navigator.pushReplacement(
                      //    context,
                      //   CupertinoPageRoute(
                      //      builder: (context) => LoginScreen()));
                    }),
                    child: const Text(
                      "Gestion des ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
