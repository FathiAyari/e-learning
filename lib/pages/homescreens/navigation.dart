import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../chat/chat.dart';
import '../../splash/screen.dart';
import '../notications/notification_screen.dart';
import '../profile/setting.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  final pages = [
    Course(),
    chat(),
    NotificationsScreen(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Text('Home'),
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
            title: Text('Notifications'),
            activeColor: Color(0xff2657ce),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings, color: Color(0xffff5954)),
            title: Text('Settings'),
            activeColor: Color(0xff2657ce),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
