// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateUsersPage extends StatefulWidget {
  final String uid;
  UpdateUsersPage({Key? key, required this.uid}) : super(key: key);

  @override
  _UpdateUsersPageState createState() => _UpdateUsersPageState();
}

class _UpdateUsersPageState extends State<UpdateUsersPage> {
  final _formKey = GlobalKey<FormState>();

  // Updaing user
  CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUser(nomPrenom, email, phone , uid,  ) {
    return user
        .doc(uid)
        .update({'nomPrenom': nomPrenom, 'email': email, 'phone' : phone , 'uid' :uid, })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Modifer utilisateur"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.uid)
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
              var nomPrenom = data!['nomPrenom'];
              var email = data['email'];
              var phone = data ['phone'];
              var uid = data['uid'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: nomPrenom,
                        autofocus: false,
                        onChanged: (value) => nomPrenom = value,
                        decoration: InputDecoration(
                          labelText: 'nomPrenom: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {//
                              if (value!.isEmpty) {
                            return 'Veuiller saisir votre nom utilisateur ';
                            }
                         if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                             return "le nom d'utilisateur est incorrecte";
                           }
                           return null;},
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: email,
                        autofocus: false,
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                          labelText: 'Email: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                             if (value!.isEmpty) {//
                              return 'Veuiller saisir votre Email';
                            }
                           if(!RegExp(
                         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^¨_'{}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)){
                          return "L'addresse Email est incorecte  ";
                          }
                           return null;}
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: phone,
                        autofocus: false,
                        onChanged: (value) => phone = value,
                        decoration: InputDecoration(
                          labelText: 'Numero: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                             if (value!.isEmpty) {//
                              return 'Veuiller saisir votre Email';
                            }
                           if(!RegExp(
                         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^¨_'{}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)){
                          return "L'addresse Email est incorecte  ";
                          }
                           return null;}
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
                                updateUser(widget.uid, nomPrenom, email, phone );
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
