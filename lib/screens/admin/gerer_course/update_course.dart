// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateCourse extends StatefulWidget {
  final String id;
  UpdateCourse({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateCourseState createState() => _UpdateCourseState();
}

class _UpdateCourseState extends State<UpdateCourse> {
  final _formKey = GlobalKey<FormState>();

  // Updaing user
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  Future<void> UpdateCourse(id, titre, image,description , UrlVideo , descriptionVideo ) {
    return courses
        .doc(id)
        .update({'titre': titre, 'image': image, 'description': description,
         'UrlVideo' :UrlVideo, 'descriptionVideo':descriptionVideo })
        .then((value) => print("course Updated"))
        .catchError((error) => print("Failed to update course: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Modifer cours"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('courses')
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
              var titre = data!['titre'];
              var image = data['image'];
              var description = data ['description'];
              var UrlVideo = data['UrlVideo'];
              var descriptionVideo = data['descriptionVideo'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: titre,
                        autofocus: false,
                        onChanged: (value) => titre= value,
                        decoration: InputDecoration(
                          labelText: 'titre: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter titre';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: image,
                        autofocus: false,
                        onChanged: (value) => image = value,
                        decoration: InputDecoration(
                          labelText: 'image: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter image';
                          } else if (!value.contains('@')) {
                            return 'Please Enter Valid image';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: description,
                        autofocus: false,
                        onChanged: (value) => description = value,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'description: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter description';
                          }
                          return null;
                        },
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue:  UrlVideo ,
                        autofocus: false,
                        onChanged: (value) =>  UrlVideo  = value,
                        decoration: InputDecoration(
                          labelText: ' URl du Video : ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter URl du Video';
                          } else if (!value.contains('@')) {
                            return 'Please Enter valid URl du Video ';
                          }
                          return null;
                        },
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: descriptionVideo,
                        autofocus: false,
                        onChanged: (value) => descriptionVideo = value,
                        decoration: InputDecoration(
                          labelText: 'description du Video: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter description du Video';
                          } else if (!value.contains('@')) {
                            return 'Please Enter Valid description';
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
                                UpdateCourse(widget.id, titre, image, description,UrlVideo ,descriptionVideo);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 18.0),
                            ),
                             style: ElevatedButton.styleFrom(
                                primary: Color(0xff2657ce)),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            child: Text(
                              'Reset',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary:Colors.redAccent),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
