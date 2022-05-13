// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCourse extends StatefulWidget {
  AddCourse({Key? key}) : super(key: key);

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final _formKey = GlobalKey<FormState>();
  var titre = "";
  var image = "";
  var description = "";
  var UrlVideo ="";
  var descriptionVideo ="";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final _titreController = TextEditingController();
  final _imageController = TextEditingController();//hachty bih drop dowen =choi un fichier 
  final _descriptionController = TextEditingController();
  final _UrlVideoController = TextEditingController();
  final _descriptionVideoController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titreController.dispose();
    _imageController.dispose();
    _descriptionController.dispose();
    _UrlVideoController.dispose();
    _descriptionVideoController.dispose();
    super.dispose();
  }

  clearText() {
    _titreController.clear();
    _imageController.clear();
    _descriptionController.clear();
    _UrlVideoController.clear();
    _descriptionVideoController.clear();
  }

  // Adding Course
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  Future<void> AddCourse() {//create
    return courses
        .add({'titre': titre, 'image': image, 'description': description,
         'UrlVideo' :UrlVideo, 'descriptionVideo':descriptionVideo})
        .then((value) => print('course Added'))
        .catchError((error) => print('Failed to Add course: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.redAccent ,
        title: Text("Ajouter cours"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'titre: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: _titreController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter titre';
                    }
                    return null;
                  },
                ),
              ),
              //drop dowen nhebha ?
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'image: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: _imageController,
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
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'description: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: _descriptionController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: ' URL du Video: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: _UrlVideoController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: ' description du Video: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: _descriptionVideoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter titre';
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
                          setState(() {
                            titre =  _titreController.text.trim();
                            image = _imageController.text.trim();
                            description = _descriptionController.text.trim();
                            UrlVideo = _UrlVideoController.text.trim();
                            descriptionVideo = _descriptionVideoController.text.trim();
                            AddCourse();
                            clearText();
                          });
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 18.0,),
                       ),
                    style: ElevatedButton.styleFrom(primary: Color(0xff2657ce)),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
