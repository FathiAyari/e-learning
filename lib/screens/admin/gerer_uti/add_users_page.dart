// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUsersPage extends StatefulWidget {
  AddUsersPage({Key? key}) : super(key: key);

  @override
  _AddUsersPageState createState() => _AddUsersPageState();
}

class _AddUsersPageState extends State<AddUsersPage> {
  final _formKey = GlobalKey<FormState>();
  var nomPrenom = "";
  var email = "";
  var phone = "";
 
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final _nomPrenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
 

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nomPrenomController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
   
    super.dispose();
  }

  clearText() {
    _nomPrenomController.clear();
    _emailController.clear();
    _phoneController.clear();
   
  }

  // Adding Student
  CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return user
        .add({'nomPrenom': nomPrenom, 'email': email, 'phone':phone ,})
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.redAccent ,
        title: Text("Ajouter un utilisateur"),
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
                    labelText: 'nomPrenom: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: _nomPrenomController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Email: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: _emailController,
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
                  controller:  _phoneController,
                  autofocus: false,
                  decoration: InputDecoration(
                     labelText: 'Numero: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                    validator: (value) {
                                  if (value.toString().length < 6) {
                                    return 'Password should be longer or equal to 6 characters';
                                  } else {
                                    return null;
                                  }
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
                            nomPrenom = _nomPrenomController.text.trim();
                            email = _emailController.text.trim();
                            phone = _phoneController.text.trim();
                            addUser();
                            clearText();
                          });
                        }
                      },
                      child: Text(
                        'Sauvegarder',
                        style: TextStyle(fontSize: 18.0,),
                       ),
                    style: ElevatedButton.styleFrom(primary: Color(0xff2657ce)),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'Réientaliser',
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
