//L3IN MATEKHDEMLICH F PASS

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../pages/auth/signup.dart';
import '../../pages/forgotpass/forgot_password.dart';

bool showSpinner = false; //hedhi aka lcnx li dour

late TextEditingController _emailController = new TextEditingController();
late TextEditingController _passController = new TextEditingController();
late bool _isPassVisible = true;
final _formKey = GlobalKey<FormState>();
bool remember = false;

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key? key}) : super(key: key);
  @override
  _LoginAdminState createState() => _LoginAdminState();
}

/*AuthService _authServices = new AuthService();*/
//instance ta3 l authservices eli fyha les fonctions lkol

class _LoginAdminState extends State<LoginAdmin> {
  //final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner, //bch tekhou l position ta3 l variable
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 50,
                        ),
                        Text('Hello Admin ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Color(0xff2657ce))),
                        SizedBox(height: 8),
                        Text('Get Started',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                color: Color(0xffff5954))),
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
                          decoration: InputDecoration(
                            prefixIcon: const Icon(CupertinoIcons.mail_solid,
                                color: Color(0xffff5954)),
                            labelText: 'Email',
                            hintText: 'Entrer votre Email',
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
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          hintText: 'Entrer votre Mot de passe ',
                          prefixIcon: const Icon(CupertinoIcons.lock_fill,
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
                    Checkbox(
                        value: remember,
                        activeColor: Color(0xff2657ce),
                        onChanged: (value) {
                          setState(() {
                            remember = value!;
                          });
                        }),
                    Text("Remmber me ",
                        style: TextStyle(color: Color(0xff2657ce))),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                            child: CupertinoButton(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(60)),
                                color: const Color(0xffff5954),
                                onPressed: (() async {
                                  /*      if (_formKey.currentState!.validate()) {
                                    print("sucess");
                                    if (_passController.text
                                            .trim()
                                            .isNotEmpty &&
                                        _emailController.text
                                            .trim()
                                            .isNotEmpty) {
                                      dynamic credential =
                                          await _authServices.loginUser(
                                        _emailController.text.trim(),
                                        _passController.text.trim(),
                                      );
                                      if (credential == null) {
                                        const SnackBar(
                                          content: Text(
                                              'Email/Password are invalid'),
                                        );
                                        */ /*ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);*/ /*
                                      } else {
                                        Navigator.pushReplacement(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    FonctionaliteAdmin()));
                                      }
                                    }
                                  }*/
                                }),
                                child: const Text('Connexion',
                                    style: TextStyle(color: Colors.white)))),
                      ],
                    ),
                  ),

                  // ma3ndich compte
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Vous n'avez pas un compte?",
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          child: const Text("S'inscrire !",
                              style: TextStyle(color: Color(0xff2657ce))))
                    ],
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
