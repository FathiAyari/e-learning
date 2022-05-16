import 'package:ahlem/screens/admin/update_student_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListStudentPage extends StatefulWidget {
  ListStudentPage({Key? key}) : super(key: key);

  @override
  _ListStudentPageState createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  // For Deleting User
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            print("Quelque chose s'est mal passé!");
          }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length != 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20)),
                        child: ExpansionTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 22,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      snapshot.data!.docs[index].get('Url')),
                                  radius: 20,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "${(snapshot.data!.docs[index].get('name'))}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          children: [
                            ListTile(
                              title: Text(
                                "Email: ${(snapshot.data!.docs[index].get('Email'))}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Role: ${(snapshot.data!.docs[index].get('Role'))}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "GSM: ${(snapshot.data!.docs[index].get('Gsm'))}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateStudentPage(
                                      id: snapshot.data!.docs[index].id,
                                    ),
                                  ),
                                )
                              },
                              child: Text(
                                'Editer utilisateur',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text("Pas encore de données!"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
