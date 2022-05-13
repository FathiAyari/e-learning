//hedhy f west l profile ki nenzel my account heya hedhy l contenu ta3 awel boutton li ena 3ayetlha f page bodyProfil
//3andi mochkol f annuler ki narja3 lel profile yetna7a l navigation bar

import 'package:ahlem/pages/profile/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/auth_services.dart';
import '../homescreens/navigation.dart';
import 'components/profile_pic.dart';

AuthService _authServices = new AuthService();
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
TextEditingController _nomPrenomController = new TextEditingController();
TextEditingController _emailController = new TextEditingController();
TextEditingController _numController = new TextEditingController();
TextEditingController _passController = new TextEditingController();
bool _isPassVisible = true;

final _formKey = GlobalKey<FormState>();

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nomPrenomController.dispose();
    _emailController.dispose();
    _numController.dispose();
    _passController.dispose();
    super.dispose();
  }

  clearText() {
    _nomPrenomController.clear();
    _emailController.clear();
    _numController.clear();
    _passController.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            /*  Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Settings()));
                     */
                          },
                          icon: const Icon(CupertinoIcons.arrow_left,
                              color: Color(0xffff5954)),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Modifier profile",
                            style: TextStyle(
                                color: Color(0xFF8B8B8B), fontSize: 18)),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    profilpic(),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Ahlém BOUGHALMI",
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
                            hintText: ' Ahlém Bl',
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
                              hintText: 'blahlem916@gamail.com',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                            hintText: '',
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
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: _passController,
                          obscureText: true,
                          maxLength: 8,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            hintText: '********',
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
                        )),

                    // Boutton Enregistrer
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                              child: CupertinoButton(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(60)),
                                  color: Color(0xffff5954),
                                  onPressed: (() {
                                    _authServices.updateUserDocument(
                                        FirebaseAuth.instance.currentUser!.uid);
                                    /*if(_formKey.currentState!.validate()){
                     _formKey.currentState!.save();
                     print('sucess');*/
                                    Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                Navigation()));
                                  }),
                                  child: const Text('Enregistrer',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )))),

                          ///Boutton annuler
                          const SizedBox(
                            width: 2,
                          ),
                          Expanded(
                              child: CupertinoButton(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(60)),
                                  color: const Color(0xFFF1E6FF),
                                  onPressed: (() {
                                    Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                SettingsPage()));
                                  }),
                                  child: const Text('Annuler',
                                      style: TextStyle(
                                          color: Color(0xff2657ce))))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
