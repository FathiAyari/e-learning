import 'package:ahlem/pages/auth/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../admin/login_admin.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bch tba3den 3al bare ta3 notification
      body: SafeArea(
          // heya l'espace ta3s screen mte3i
          child: Container(
        // hatit l contenu lkol f west container
        decoration: const BoxDecoration(
          // decoration ta3 background
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffff5954),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          //ya3ni lektiba temchy vertical
          mainAxisAlignment: MainAxisAlignment.center, //lektiba  lkol f center
          children: [
            Row(
              //hedhy ligne loula fiha titre WELCOME TO EDUCA
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 6,
                ),
                Text(
                  'WELCOME TO EDUCA',
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
            SvgPicture.asset(
              "assets/icons/educate.svg",
              height: 90,
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
                              builder: (context) => LoginAdmin()));
                    }),
                    child: const Text(
                      'Admin',
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
                              builder: (context) => LoginScreen()));
                    }),
                    child: const Text(
                      "utilisateur",
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
