import 'package:ahlem/services/remember_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'edit_profile.dart';

//CarsServices _carsServices = CarsServices();
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  RememberController rememberController = RememberController();
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
            text: 'Mon compte',
            press: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => EditProfile()));
            },
          ),
          SizedBox(
            height: 40,
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),
          ProfileMenu(
            icon: 'assets/icons/deconnexion.svg',
            text: 'Deconnesxion',
            press: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("êtes-vous sûr de vouloir vous déconnecter?"),
                      actions: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Non"))),
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
                                  "Oui",
                                  style: TextStyle(color: Colors.white),
                                ))),
                      ],
                    );
                  });
            },
          ),
          ProfileMenu(
            icon: 'assets/icons/interrogatoire.svg',
            text: 'Aide',
            press: () {},
          ),
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
