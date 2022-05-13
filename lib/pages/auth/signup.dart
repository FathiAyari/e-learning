//ne9sa reg exp confirm pass ?
import 'package:ahlem/pages/auth/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../services/auth_services.dart';

bool showSpinner = false; //hedhi aka lcnx li dour

TextEditingController _numController = new TextEditingController();
TextEditingController _nomPrenomController = new TextEditingController();
TextEditingController _emailController = new TextEditingController();
TextEditingController _passController = new TextEditingController();
TextEditingController _confirmPassController = new TextEditingController();
bool _isPassVisible = true;
final _formKey = GlobalKey<FormState>();

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
AuthService _authServices =
    new AuthService(); //instance ta3 l authservices eli fyha les fonctions lkol

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
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
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "S'inscrire",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xff2657ce),
                        ),
                      ),

                      //  const SizedBox(height: 16,),
                      //  SvgPicture.asset( "assets/icons/undraw_verified_re_4io7.svg", height: 120 ),

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
                              hintText: 'Entrer votre nom ',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: const BorderSide(
                                      color: Color(0xffff5954)),
                                  gapPadding: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: const BorderSide(
                                      color: Color(0xffff5954)),
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
                                prefixIcon: const Icon(
                                    CupertinoIcons.mail_solid,
                                    color: Color(0xffff5954)),
                                labelText: 'Email',
                                hintText: 'Entrer votre Email',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 42, vertical: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: const BorderSide(
                                      color: Color(0xffff5954)),
                                  gapPadding: 10,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: const BorderSide(
                                      color: Color(0xffff5954)),
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
                              hintText: 'Entrer votre Numero',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: const BorderSide(
                                      color: Color(0xffff5954)),
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
                                return 'phone number should be longer or equal to 6 number';
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
                            obscureText: true,
                            // maxLength: 8,
                            maxLines: 1,
                            controller: _passController,
                            decoration: InputDecoration(
                                labelText: 'Mot de passe',
                                hintText: 'Saisir votre Mot de passe ',
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 42, vertical: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: const BorderSide(
                                      color: Color(0xffff5954)),
                                  gapPadding: 10,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: const BorderSide(
                                      color: Color(0xffff5954)),
                                  gapPadding: 10,
                                )),
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
                            obscureText: true,
                            controller: _confirmPassController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: 'Confirmer le  Mot de passe',
                              hintText: 'Confirmer',
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
                              if (value.toString().length < 6) {
                                return 'Password should be longer or equal to 6 characters';
                              } else {
                                return null;
                              }
                            },
                          )),
                      //L Boutton
                      const SizedBox(height: 13),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                                child: CupertinoButton(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(60)),
                                    color: const Color(0xffff5954),
                                    onPressed: (() async {
                                      if (_formKey.currentState!.validate()) {
                                        print("SUCESS");
                                        if (_passController.text
                                                .trim()
                                                .isNotEmpty &&
                                            _emailController.text
                                                .trim()
                                                .isNotEmpty) {
                                          dynamic credential =
                                              await _authServices.registerUser(
                                            _emailController.text.trim(),
                                            _passController.text.trim(),
                                            _nomPrenomController.text.trim(),
                                          );
                                          if (credential == null) {
                                            const SnackBar(
                                              content: Text(
                                                  'Email/Password are invalid'),
                                            );
                                            /*ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
                                          } else {
                                            Navigator.pushReplacement(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()));
                                          }
                                        }
                                      }
                                    }),
                                    child: const Text('Enregistrer',
                                        style:
                                            TextStyle(color: Colors.white)))),
                          ],
                        ),
                      ),
                      //Do you have an account
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Vous avez déjà un compte?',
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: const Text(
                                "Se Connecter",
                                style: TextStyle(
                                    //???
                                    color: Color(0xff2657ce)),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} //hedhi ta3 s'inscrire
//OnPressed:()async{{
//setState((){
//showSpinner = true;}
//);
//try{
//final user = await _auth.createWithEmailAndPass(
//email:_EmailController,password: _PassController);
//if(user !=null){
// Navigator.pushReplacement(
// context,
//CupertinoPageRoute(
// builder: (context) => LoginScreen()));
// //setState((){
//showSpinner = true;}
//);}}
// }catch(e){
// print(e);}

//  if (credentials == null){
//    const snackBar = SnackBar(
//     content: Text('Email/Password are invalid'),);
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }else{
//  Navigator.pushReplacement(context, CupertinoPageRoute(
//  builder: (context) => LoginScreen()));
//   }

// dynamic credentials =
//  await _authServices.registerUser(
//   'ahlem@gmail.com','nomprenom','password');
// if(_formKey.currentState!.validate()){
//  String nomPrenom = _nomPrenomController.text.trim();
//  String email = _emailController.text.trim();
// String password = _passController.text.trim();
//   _authServices.registerUser(nomPrenom, email, password);
// }else

//hedhy ta3 dhie tekhdem
/* if(_formKey.currentState!.validate()){
                           String email=_emailController.text.trim();
                           String numero = _numController.text.trim();
                           String nomPrenom = _nomPrenomController.text.trim();
                          String psw = _passController.text.trim();

                       debugPrint('movieTitle: $email');
                           await _authServices.registerUser(
                              email,
                             psw,
                             );}*/
