import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../../Models/user.dart';
import '../../../../utils/constant.dart';
import 'Messenger.dart';

class buildMessages extends StatefulWidget {
  @override
  _buildMessagesState createState() => _buildMessagesState();
}

class _buildMessagesState extends State<buildMessages> {
  var user = GetStorage().read("user");
  ScrollController controller = new ScrollController();
  String reseceiverCase = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: Constants.screenHeight * 0.1,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("Messages"),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: snapshotMessages
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  List msg = [];

                  if (snapshot.hasData) {
                    if (snapshot.data!.size != 0) {
                      final messages = snapshot.data!.docs.reversed;

                      for (var message in messages) {
                        final getText = message.get('text');
                        final getSender = message.get('sender');
                        final getDestination = message.get('destination');
                        final getTime = message.get('time');
                        final Map<String, String> messageWidget = {
                          'getText': getText,
                          'getTime': DateFormat('kk:mm').format(
                              DateTime.parse(getTime.toDate().toString())),
                          'getSender': getSender,
                          'getDestination': getDestination,
                        };
                        if ((((messageWidget["getSender"] == user['email']) ||
                            (messageWidget["getDestination"] ==
                                user['email'])))) {
                          msg.add(messageWidget);
                        }
                      }

                      for (int i = 0; i < msg.length; i++) {
                        for (int j = i + 1; j < msg.length; j++) {
                          if ((msg[i]["getSender"] == msg[j]["getSender"]) &&
                                  (msg[i]["getDestination"] ==
                                      msg[j]["getDestination"]) ||
                              (msg[i]["getSender"] ==
                                      msg[j]["getDestination"]) &&
                                  (msg[i]["getSender"] ==
                                      msg[j]["getDestination"])) {
                            msg[j] = {
                              'getText': '',
                              'getSender': '',
                              'getDestination': '',
                            };
                          }
                        }
                      }

                      for (int i = 0; i < msg.length; i++) {
                        if (msg[i]["getSender"] == "") {
                          msg.remove(msg[i]);
                          i--;
                        }
                      }
                      print(msg.length);
                      return Column(
                        children: [
                          Expanded(
                              child: ListView.builder(
                            itemCount: msg.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  var destination =
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .where(
                                            "Email",
                                            isEqualTo: this.user['email'] ==
                                                    msg[index]["getDestination"]
                                                ? "${msg[index]["getSender"]}"
                                                : "${msg[index]["getDestination"]}",
                                          )
                                          .get();
                                  var user = Cusers.fromJson(destination.docs
                                      .toList()
                                      .first
                                      .data() as Map<String, dynamic>);

                                  Get.to(Messenger(
                                    user: user,
                                  ));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Stack(
                                                alignment: AlignmentDirectional
                                                    .bottomEnd,
                                                children: [
                                                  if (user['email'] ==
                                                      msg[index]
                                                          ["getSender"]) ...[
                                                    CircleAvatar(
                                                      radius: 35,
                                                      backgroundColor:
                                                          Colors.indigo,
                                                      child: CircleAvatar(
                                                          radius: 33,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${user["url"]}")),
                                                    ),
                                                  ] else ...[
                                                    StreamBuilder<
                                                            QuerySnapshot>(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection("users")
                                                            .where('Email',
                                                                isEqualTo: msg[
                                                                        index][
                                                                    "getSender"])
                                                            .snapshots(),
                                                        builder: (BuildContext
                                                                context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.indigo,
                                                              radius: 35,
                                                              child: CircleAvatar(
                                                                  radius: 33,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          "${snapshot.data!.docs[0].get('Url')}")),
                                                            );
                                                          } else {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }
                                                        })
                                                  ],
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .only(
                                                            bottom: 3, end: 3),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.green.shade700,
                                                      radius: 7,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                            width: size.width * 0.03,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${msg[index]["getText"]}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                                "${msg[index]["getTime"]}"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            padding: EdgeInsets.all(20),
                            controller: controller,
                          )),
                        ],
                      );
                    } else
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/message.png',
                              height: Constants.screenHeight * 0.1,
                            ),
                            Text("Pas des messages encore.")
                          ],
                        ),
                      );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
