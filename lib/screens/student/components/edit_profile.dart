import 'package:ahlem/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../student_home_page.dart';

/*AuthService _authServices = new AuthService();*/
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nomPrenomController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _numController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nomPrenomController.dispose();
    _emailController.dispose();
    _numController.dispose();
    _passController.dispose();
    super.dispose();
  }

  var user = GetStorage().read("user");
  clearText() {
    _nomPrenomController.clear();
    _emailController.clear();
    _numController.clear();
    _passController.clear();
  }

  getUserData() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user['id'])
        .get();

    Cusers cusers = Cusers.fromJson(data.data() as Map<String, dynamic>);
    setState(() {
      _nomPrenomController.text = cusers.name;
      _emailController.text = cusers.Email;
      _numController.text = cusers.Gsm;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(HomePageStudent());
                        },
                        icon: const Icon(CupertinoIcons.arrow_left,
                            color: Color(0xffff5954)),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 53,
                    backgroundColor: Colors.indigo,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("${user['url']}"),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${user['name']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xff2657ce),
                    ),
                  ),

                  //NAME
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: _nomPrenomController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(CupertinoIcons.person_fill,
                              color: Color(0xffff5954)),
                          labelText: 'Nom utilisateur',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 42, vertical: 20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide:
                                  const BorderSide(color: Color(0xffff5954)),
                              gapPadding: 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide:
                                  const BorderSide(color: Color(0xffff5954)),
                              gapPadding: 10),
                        ),
                        validator: (value) {
                          //
                          if (value!.isEmpty) {
                            return 'Veuiller saisir votre nom utilisateur ';
                          }
                          if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "le nom d'utilisateur est incorrecte";
                          }
                          return null;
                        },
                      )),

                  //Email
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(CupertinoIcons.mail_solid,
                                color: Color(0xffff5954)),
                            labelText: 'Email',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide:
                                  const BorderSide(color: Color(0xffff5954)),
                              gapPadding: 10,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide:
                                  const BorderSide(color: Color(0xffff5954)),
                              gapPadding: 10,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              //
                              return 'Veuiller saisir votre Email';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^¨_'{}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "L'addresse Email est incorecte  ";
                            }
                            return null;
                          })),
                  //phone
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: _numController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(CupertinoIcons.phone_fill,
                              color: Color(0xffff5954)),
                          labelText: 'Numero ',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 42, vertical: 20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide:
                                  const BorderSide(color: Color(0xffff5954)),
                              gapPadding: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide:
                                const BorderSide(color: Color(0xffff5954)),
                            gapPadding: 10,
                          ),
                        ),
                        validator: (value) {
                          if (value.toString().length < 6) {
                            return 'Password should be longer or equal to 6 characters';
                          } else {
                            return null;
                          }
                        },
                      )),

                  //Password
                  const SizedBox(
                    height: 15,
                  ),
                  /*            Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: _passController,
                        obscureText: true,
                        maxLength: 8,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          prefixIcon: Icon(CupertinoIcons.lock_fill,
                              color: Color(0xffff5954)),
                          suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  _isPassVisible = !_isPassVisible;
                                });
                              },
                              child: Icon(
                                  _isPassVisible
                                      ? CupertinoIcons.eye_slash_fill
                                      : Icons.remove_red_eye,
                                  color: const Color(0xffff5954))),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 42, vertical: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide:
                                const BorderSide(color: Color(0xffff5954)),
                            gapPadding: 10,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide:
                                  const BorderSide(color: Color(0xffff5954)),
                              gapPadding: 10),
                        ),
                        validator: (value) {
                          if (value.toString().length < 6) {
                            return 'Password should be longer or equal to 6 characters';
                          } else {
                            return null;
                          }
                        },
                      )),*/

                  // Boutton Enregistrer
                  const SizedBox(height: 10),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: (() async {
                                  setState(() {
                                    loading = true;
                                  });
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc("${user['id']}")
                                      .update({
                                    "Email": _emailController.text,
                                    "Gsm": _numController.text,
                                    "name": _nomPrenomController.text
                                  });
                                  Future.delayed(Duration(seconds: 1), () {
                                    setState(() {
                                      loading = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Mise à jour fait avec succès ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  });
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text('Enregistrer',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: (() {

                                  Get.to(HomePageStudent());
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text('Annuler',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                )),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
