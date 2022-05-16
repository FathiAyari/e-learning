import 'package:ahlem/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;

  UpdateStudentPage({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();

  // Updating Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUser(id, name, gsm) {
    return students
        .doc(id)
        .update({'name': name, 'Gsm': gsm})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['name'];
              var gsm = data!['Gsm'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: Constants.screenHeight * 0.05,),
                      Expanded(child: ListView(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 52,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data!.data()!['Url']),
                              radius: 50,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              initialValue: name,
                              autofocus: false,
                              onChanged: (value) => name = value,
                              decoration: InputDecoration(
                                labelText: 'Name: ',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              initialValue: gsm,
                              autofocus: false,
                              onChanged: (value) => gsm = value,
                              decoration: InputDecoration(
                                labelText: 'GSM: ',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, otherwise false.
                                    if (_formKey.currentState!.validate()) {
                                      updateUser(widget.id, name, gsm);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    'Enregistrer',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => {
                                    Navigator.pop(context),
                                  },
                                  child: Text(
                                    'Annuler',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),)
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
