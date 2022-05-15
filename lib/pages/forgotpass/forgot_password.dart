import 'package:ahlem/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/signin.dart';
import '../auth/signup.dart';

final _formKey = GlobalKey<FormState>();

TextEditingController _emailController = new TextEditingController();

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    icon: const Icon(CupertinoIcons.arrow_left),
                  ),
                  SizedBox(
                    width: Constants.screenWidth * 0.15,
                  ),
                  Text("Mot de passe oublieé",
                      style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 18)),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: Constants.screenHeight * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Mot de passe oublieé",
                          style: TextStyle(
                              color: Color(0xff2657ce),
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        " saisir l'addresse email relative a votre compte  pour envoyer le code de réinitialiser le mot de passe",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),

              //Email
              const SizedBox(
                height: 42,
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
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
                          borderSide: const BorderSide(color: Colors.indigo),
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
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: CupertinoButton(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Colors.indigo,
                            onPressed: (() {
                              if (_formKey.currentState!.validate()) {}
                            }),
                            child: const Text('réientaliser mot de passe',
                                style: TextStyle(color: Colors.white)))),
                  ],
                ),
              ),
              SizedBox(
                height: Constants.screenHeight * 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Vous n'avez pas un compte ?",
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
                      child: const Text("S'inscrire",
                          style: TextStyle(color: Color(0xff2657ce))))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
