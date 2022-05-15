//L3IN MATEKHDEMLICH F PASS

import 'dart:io';

import 'package:ahlem/models/user.dart';
import 'package:ahlem/pages/auth/signup.dart';
import 'package:ahlem/services/remember_controller.dart';
import 'package:ahlem/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../services/auth_services.dart';
import '../forgotpass/forgot_password.dart';
import 'infoMessage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RememberController controller = RememberController();
  final _formKey = GlobalKey<FormState>();
  bool remember = false;
  bool loading = false;
  bool showSpinner = false; //hedhi aka lcnx li dour
  late TextEditingController _emailController = new TextEditingController();
  late TextEditingController _passController = new TextEditingController();
  late bool _isPassVisible = true;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("vous etes sur de sortir ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" Non"));
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: avoidReturnButton,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner, //bch tekhou l position ta3 l variable
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: Constants.screenHeight * 0.1,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 50,
                        ),
                        Text('Se Connecter',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Color(0xff2657ce)))
                      ]),
                  //image
                  // const SizedBox(height: 16,),
                  //  SvgPicture.asset("assets/images/bording1.jpg", height: 200),

                  //Email
                  const SizedBox(
                    height: 42,
                  ),

                  Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon:
                                const Icon(Icons.mail, color: Colors.indigo),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.5),
                            hintText: 'Entrer votre Email',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 20),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.indigo),
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

                  //Password
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: _passController,
                        obscureText: _isPassVisible,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Entrer votre Mot de passe ',
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.indigo),
                          suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  _isPassVisible = !_isPassVisible;
                                });
                              },
                              child: Icon(
                                  _isPassVisible
                                      ? CupertinoIcons.eye_fill
                                      : CupertinoIcons.eye_slash_fill,
                                  color: Colors.indigo)),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 42, vertical: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: Colors.indigo),
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

                  //forgot
                  const SizedBox(height: 2),
                  Row(children: [
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ForgotPass()));
                        },
                        child: const Text('Mot de passe oublieé ?',
                            style: TextStyle(color: Colors.grey)))
                  ]),

                  //Connexion
                  //  const SizedBox(height: 15),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CupertinoButton(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.indigo,
                                      onPressed: (() async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          AuthServices()
                                              .signIn(_emailController.text,
                                                  _passController.text)
                                              .then((value) async {
                                            if (value) {
                                              final FirebaseAuth auth =
                                                  await FirebaseAuth.instance;
                                              final User? user =
                                                  await auth.currentUser;
                                              final uid = user!.uid;
                                              var UserData =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(uid)
                                                      .get();

                                              if (Cusers.fromJson(
                                                          UserData.data()
                                                              as Map<String,
                                                                  dynamic>)
                                                      .Role ==
                                                  "admin") {
                                                // test de role
                                                await controller.RememberAdmin(
                                                    Cusers.fromJson(
                                                        UserData.data() as Map<
                                                            String, dynamic>));
                                                //navigation
                                              } else if (Cusers.fromJson(
                                                          UserData.data()
                                                              as Map<String,
                                                                  dynamic>)
                                                      .Role ==
                                                  "client") {
                                                await controller.RememberClient(
                                                    Cusers.fromJson(
                                                        UserData.data() as Map<
                                                            String, dynamic>));
                                                //navigation
                                                print("client");
                                              }
                                              setState(() {
                                                loading = false;
                                              });
                                            } else {
                                              setState(() {
                                                loading = false;
                                              });
                                              InfoMessage(
                                                press: () {
                                                  Get.back();
                                                },
                                                lottieFile:
                                                    "assets/images/error.json",
                                                action: "Ressayer",
                                                message:
                                                    "Merci de vierfier vos données ",
                                              ).show(context);
                                            }
                                          });
                                        }
                                      }),
                                      child: const Text('Connexion',
                                          style:
                                              TextStyle(color: Colors.white)))),
                            ],
                          ),
                        ),

                  // ma3ndich compte

                  Container(
                    height: Constants.screenHeight * 0.3,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Vous n'avez pas un compte?",
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        TextButton(
                            onPressed: () {
                              Get.to(SignupScreen());
                            },
                            child: const Text("S'inscrire !",
                                style: TextStyle(color: Color(0xff2657ce))))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
