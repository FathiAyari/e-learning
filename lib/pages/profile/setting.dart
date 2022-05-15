import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/settings_notif.dart';
import 'edit_profile.dart';

//CarsServices _carsServices = CarsServices();
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            IconButton(
              onPressed: () {
                /*       Get.to()*/
              },
              icon: const Icon(CupertinoIcons.arrow_left,
                  color: Color(0xffff5954)),
            ),
          ]),

          SizedBox(
            height: 10,
          ),
          Text("Paramétre",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xff2657ce),
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 40,
          ),

          ProfileMenu(
            icon: 'assets/icons/utilisateur.svg',
            text: 'My account',
            press: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => EditProfile()));
            },
          ),

          SizedBox(
            height: 40,
          ),
          ProfileMenu(
            //HEDHOM L MENU TA3 L PROFILE
            icon: 'assets/icons/cloche.svg',
            text: 'Notifications',
            press: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => setNotif()));
            },
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),

          ProfileMenu(
            icon: 'assets/icons/deconnexion.svg',
            text: 'Deconnesxion',
            press: () {
              /*           _authService.logout().then((value) => Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => LoginScreen())));*/
            },
          ),
          ProfileMenu(
            icon: 'assets/icons/interrogatoire.svg',
            text: 'Aide',
            press: () {},
          ),
          //boutton li bch tfasakhli user
          TextButton(
              onPressed: () {
                /*           _authService.deleteUser();*/
              },
              child: Text('delete john')), //bch tfasakhli user id jhon*/
        ]),
      )),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final String text, icon;
  final VoidCallback press;
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CupertinoButton(
        onPressed: press,
        borderRadius: BorderRadius.circular(15),
        padding: const EdgeInsets.all(10),
        color: Color(0xFFF5F6F9),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
              color: Color(0xffff5954),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
