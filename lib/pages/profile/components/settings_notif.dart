import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../setting.dart';

class setNotif extends StatelessWidget {
  const setNotif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                  icon: const Icon(CupertinoIcons.arrow_left,
                      color: Color(0xffff5954)),
                ),
                SizedBox(
                  width: 8,
                ),
                Text("Notification",
                    style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 18)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionsRow('New for you', true),
            buildNotificationOptionsRow('Account Activity', true),
            buildNotificationOptionsRow('Opportuny', false),
          ],
        ),
      )),
    );
  }
}

Row buildNotificationOptionsRow(String title, bool isActive) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(value: true, onChanged: (bool isActive) {}))
    ],
  );
}
