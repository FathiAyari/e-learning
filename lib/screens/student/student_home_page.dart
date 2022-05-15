import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/courses.dart';
import 'components/friends.dart';
import 'components/messages/Messages.dart';
import 'components/setting.dart';

class HomePageStudent extends StatefulWidget {
  const HomePageStudent({Key? key}) : super(key: key);

  @override
  State<HomePageStudent> createState() => _NavigationState();
}

class _NavigationState extends State<HomePageStudent> {
  int _currentIndex = 0;
  final pages = [
    Courses(),
    buildMessages(),
    NotificationsScreen(),
    SettingsPage(),
  ];
  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("vous etes sur de sortir ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" Non"));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidReturnButton,
      child: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => this._currentIndex =
              index), //set state bch t3ayetli l curentindex eli heya bch tetbadel
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.home_filled, color: Color(0xffff5954)),
              title: Text('Accueil'),
              activeColor: Color(0xff2657ce),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.message, color: Color(0xffff5954)),
              title: Text(
                'Messages',
              ),
              activeColor: Color(0xff2657ce),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.people_alt_outlined, color: Color(0xffff5954)),
              title: Text('Monde'),
              activeColor: Color(0xff2657ce),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings, color: Color(0xffff5954)),
              title: Text('Parametres'),
              activeColor: Color(0xff2657ce),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
