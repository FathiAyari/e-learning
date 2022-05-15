import 'package:ahlem/screens/student/components/messages/Messenger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../Models/user.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  width: 10,
                ),
                Text("Les Amis",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff2657ce),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("Role", isEqualTo: "client")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.length != 0) {
                        var listOfData = snapshot.data!.docs.toList();
                        List<Cusers> listOfUsers = [];
                        for (var user in listOfData) {
                          listOfUsers.add(Cusers.fromJson(
                              user.data() as Map<String, dynamic>));
                        }
                        return ListView.builder(
                            itemCount: listOfUsers.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Slidable(
                                  key: ValueKey(1),
                                  startActionPane: ActionPane(
                                    // A motion is a widget used to control how the pane animates.
                                    motion: ScrollMotion(),

                                    // All actions are defined in the children parameter.
                                    children: [
                                      // A SlidableAction can have an icon and/or a label.

                                      SlidableAction(
                                        backgroundColor: Color(0xff3dc295),
                                        foregroundColor: Colors.white,
                                        icon: Icons.cancel,
                                        label: 'Annuler',
                                        onPressed: (BuildContext context) {},
                                      ),
                                      SlidableAction(
                                        backgroundColor: Colors.indigo,
                                        foregroundColor: Colors.white,
                                        icon: Icons.send,
                                        label: 'Message',
                                        onPressed: (context) {
                                          Get.to(Messenger(
                                              user: listOfUsers[index]));
                                        },
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "${listOfUsers[index].Url}"),
                                        ),
                                        title:
                                            Text("${listOfUsers[index].name}"),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: Column(
                            children: [
                              Text("Pas de message encore "),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
