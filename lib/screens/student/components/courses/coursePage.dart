//hero?

import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:ahlem/screens/student/components/courses/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  State<CoursePage> createState() => _CursePageState();
}

class _CursePageState extends State<CoursePage> {
  ReceivePort _port = ReceivePort();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');

    send!.send([id, status, progress]);
    Text("$progress");
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  late String
      chosenImg; // late bch yfasarha wa9t li ynazel  wtitle hedhy nizid nektebha taht img arguents
  late String chosentitle;
  late String doc;
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    final Map arguments =
        ModalRoute.of(context)?.settings.arguments as Map; //ZEDT L ?
    chosenImg =
        arguments['img']; //bch t3oud taswira tetbadel ki nodkhel lel cours
    chosentitle = arguments['title'];
    doc = arguments['doc'];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0x00000ffe),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Color(0xff2657ce),
            ),
          ),
          // SizedBox(width: 10,),
          // IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.plus_app,size: 30, , color: Color(0xffff5954),))
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$chosentitle',
                  style: TextStyle(
                    // kol manodkhel l cour yetbadel titre w taswira ta3 page
                    color: Color(0xff2657ce),
                    fontSize: 20,
                  ),
                ),
                Text(
                  '${user['name']} ${doc.toUpperCase()}',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  //hedha l container lahmer ta3 taswira
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color(0xffff5954)),
                  child: Hero(
                    tag: '$chosenImg', //BCH KOL MARRA TETBADEL TASWIRA
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        image: DecorationImage(
                            image: AssetImage('assets/images/$chosenImg.png')),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ), //tawa bch nekdhou les cours kifeh bch yjiw
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Course',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("courses")
                      .doc(doc)
                      .collection("links")
                      .orderBy("index")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Slidable(
                                  key: ValueKey(1),
                                  startActionPane: ActionPane(
                                    // A motion is a widget used to control how the pane animates.
                                    motion: ScrollMotion(),

                                    // All actions are defined in the children parameter.
                                    children: [
                                      SlidableAction(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.download_rounded,
                                        label: '',
                                        onPressed:
                                            (BuildContext context) async {
                                          var test = snapshot.data!.docs[index]
                                              .get("link")
                                              .toString()
                                              .split(".mp4")[0]
                                              .split("courses")[1]
                                              .replaceAll("%20", "-");

                                          var pathFile =
                                              test.substring(3, test.length);
                                          print(pathFile);
                                          var status = await Permission.storage
                                              .request();
                                          if (status.isGranted) {
                                            Directory dir = Directory(
                                                '/storage/emulated/0/Download');
                                            final path = Directory(
                                                "/storage/emulated/0/Download/test");
                                            path.create();
                                            bool check = await File(
                                              "/storage/emulated/0/Download/" +
                                                  pathFile +
                                                  ".mp4",
                                            ).exists();

                                            if (!check) {
                                              await FlutterDownloader.enqueue(
                                                url:
                                                    '${snapshot.data!.docs[index].get("link")}',
                                                fileName: pathFile + ".mp4",

                                                showNotification:
                                                    true, // show download progress in status bar (for Android)
                                                openFileFromNotification: true,
                                                saveInPublicStorage: true,
                                                savedDir: dir
                                                    .path, // click on notification to open downloaded file (for Android)
                                              );

                                              Fluttertoast.showToast(
                                                msg:
                                                    "Element telechargé et  ajouté à la liste d'attente",
                                                backgroundColor: Colors.grey,
                                                // fontSize: 25
                                                // gravity: ToastGravity.TOP,
                                                // textColor: Colors.pink
                                              );
                                            } else {
                                              Fluttertoast.showToast(
                                                msg: "fichier deja existe",
                                                backgroundColor: Colors.grey,
                                                // fontSize: 25
                                                // gravity: ToastGravity.TOP,
                                                // textColor: Colors.pink
                                              );
                                            }
                                          }
                                        },
                                      ),
                                      SlidableAction(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        icon: Icons.play_arrow_outlined,
                                        label: '',
                                        onPressed: (context) {
                                          Get.to(DisplayVideoPlayer(
                                            videoUrl: snapshot.data!.docs[index]
                                                .get('link'),
                                          ));
                                        },
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue.withOpacity(0.5),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          //hedhy ta3 lvideo w zina mte3ha
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(17)),
                                              color: Color(0xff2657ce)),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.play_arrow,
                                              color: Colors.white,
                                            ), //w icon zda nafes l condition
                                            onPressed: () {},
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${snapshot.data!.docs[index].id}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ))
              ],
            )));
  }
}
