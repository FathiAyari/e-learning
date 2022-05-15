import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../Models/user.dart';
import '../../../../pages/auth/infoMessage.dart';

final snapshotMessages = FirebaseFirestore.instance;
ScrollController controller = new ScrollController();

class Messenger extends StatefulWidget {
  final Cusers user;

  const Messenger({required this.user});

  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  String textMessage = "";

  bool isShowSticker = false;
  bool showKeyBoard = false;
  var focusNode = FocusNode();
  var inputFlex = 1;
  var numLines;

  ScrollController controller = new ScrollController();
  TextEditingController messageController = new TextEditingController();
  @override
  var currentUser = GetStorage().read("user");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 60,
                  color: Color(0xffEAEDEF),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            await SystemChannels.textInput
                                .invokeMethod('TextInput.hide');

                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${widget.user.Url}"),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
                        "${widget.user.name}",
                        style: TextStyle(
                            fontSize: size.height * 0.028,
                            fontFamily: "NewsCycle-Bold"),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 10,
                child: Container(
                  child: Column(
                    children: [
                      MessageStreamBuilder(
                        email: widget.user.Email,
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: inputFlex,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: RawKeyboardListener(
                          focusNode: focusNode,
                          onKey: (event) {
                            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                              setState(() {
                                /* inputFlex=inputFlex+1;*/
                                numLines = '\n'
                                        .allMatches(messageController.text)
                                        .length +
                                    1;

                                if (numLines < 3) {
                                  inputFlex = numLines;
                                }
                              });
                            }
                          },
                          child: TextFormField(
                            maxLines: null,
                            onChanged: (value) {
                              textMessage = value;
                            },
                            keyboardType: TextInputType.multiline,
                            controller: messageController,
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                suffixIcon: GestureDetector(
                                  onTap: () async {},
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.emoji_emotions_outlined,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                hintText: "   Ecrire un message",
                                hintStyle: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                                fillColor: Color(
                                    0xffe6ebf5), // the color of the inside box field
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(30), //borderradius
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(30), //borderradius
                                )),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Color(0xff00a984),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (messageController.text.endsWith(" ")) {
                              InfoMessage(
                                press: () {
                                  Navigator.pop(context);
                                },
                                message: "Message ne peut pas etre vide",
                                action: 'Fermer',
                                lottieFile: 'images/error.json',
                              ).show(context);
                            } else if (messageController.text.isEmpty) {
                              InfoMessage(
                                press: () {
                                  Navigator.pop(context);
                                },
                                message: "Message ne peut pas etre vide",
                                action: 'Fermer',
                                lottieFile: 'images/error.json',
                              ).show(context);
                            } else {
                              messageController.clear();

                              snapshotMessages.collection('messages').add({
                                'text': "$textMessage",
                                'destination': "${widget.user.Email}",
                                'sender': "${currentUser['email']}",
                                'time': FieldValue.serverTimestamp(),
                              });

                              setState(() {
                                inputFlex = 1;
                              });
                            }
                          },
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageLine extends StatefulWidget {
  final String getText;
  final String getSender;
  final String getDestination;
  final DateTime getTime;
  final bool check;

  const MessageLine({
    required this.getText,
    required this.getSender,
    required this.getDestination,
    required this.check,
    required this.getTime,
  });

  @override
  _MessageLineState createState() => _MessageLineState();
}

class _MessageLineState extends State<MessageLine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment:
            widget.check ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: widget.check
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
            color: widget.check ? Color(0xff5a40a1) : Color(0xffe6ebf5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "${widget.getText}",
                style: TextStyle(
                    fontSize: 20,
                    color: widget.check ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//tous les messages
class MessageStreamBuilder extends StatefulWidget {
  final String email;
  const MessageStreamBuilder({
    required this.email,
  });
  @override
  _MessageStreamBuilderState createState() => _MessageStreamBuilderState();
}

class _MessageStreamBuilderState extends State<MessageStreamBuilder> {
  var currentUser = GetStorage().read("user");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          snapshotMessages.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> msg = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final getText = message.get('text');
          final getSender = message.get('sender');
          final getDestination = message.get('destination');
          final getTime = DateTime.now();

          if ((getSender == currentUser['email'] &&
                  getDestination == widget.email) ||
              (getSender == widget.email &&
                  getDestination == currentUser['email'])) {
            final messageWidget = MessageLine(
              getText: getText,
              getSender: getSender,
              getDestination: getDestination,
              check: currentUser['email'] == getSender ? true : false,
              getTime: getTime,
            );

            msg.add(messageWidget);
          }
        }
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          controller.animateTo(controller.position.minScrollExtent,
              duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        }); //scroll to the end of listview
        return Expanded(
            child: ListView(
          reverse: true,
          padding: EdgeInsets.all(20),
          controller: controller,
          children: msg,
        ));
      },
    );
  }
}
