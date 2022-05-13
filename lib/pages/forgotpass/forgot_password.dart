
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/signin.dart';
import '../auth/signup.dart';

final _formKey = GlobalKey <FormState >();

 TextEditingController _emailController = new TextEditingController();

class ForgotPass extends StatefulWidget {
  const ForgotPass({ Key? key }) : super(key: key);

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
           child: Column(children: [
             Row( 
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               IconButton(
                 onPressed: (){
                   Navigator.pop(
                     context,
                     CupertinoPageRoute(
                       builder: (context) => LoginScreen()));
                   },
                 icon: const Icon(CupertinoIcons.arrow_left),), 
                 SizedBox(width:8 ,),
                 Text("Mot de passe oublieé" ,style:TextStyle(color:Color(0xFF8B8B8B),fontSize: 18)),
             ],
           ),
            const  SizedBox(height: 16,),
             SizedBox(
               width: double.infinity,
               child: Column(
                 children:const  [
                    Text("Mot de passe oublieé",
                     style: TextStyle(color:Color(0xff2657ce) ,
                     fontSize: 28,
                     fontWeight: FontWeight.bold)),
                   Text(" saisir l'addresse email relative a votre compte  pour envoyer le code de réinitialiser le mot de passe",
                   textAlign: TextAlign.center,)
                ],  
               ),
             ),
              
             
          //Email        
                const SizedBox(height: 42,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                      child: TextFormField(
                        controller: _emailController,
                        decoration:  InputDecoration(
                          prefixIcon:  const Icon(CupertinoIcons.mail_solid,
                          color:Color(0xffff5954)),
                          labelText : 'Email*',
                          hintText:'Email', 
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const  EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                          enabledBorder: OutlineInputBorder(
                             borderRadius:BorderRadius.circular(28) ,
                             borderSide:const  BorderSide(color:Color(0xffff5954)),
                             gapPadding: 10,),
                        focusedBorder:  OutlineInputBorder(
                             borderRadius:BorderRadius.circular(28) ,
                             borderSide: const BorderSide(color:Color(0xffff5954)),
                             gapPadding: 10,),),
                       validator: (value) {
                        if (value!.isEmpty) {//
                         return 'Veuiller saisir votre Email';
                       }
                        if(!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^¨_'{}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                   .hasMatch(value)){
                      return "L'addresse Email est incorecte  ";
                       }
                      return null;})),
                       const SizedBox(height: 15),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: Row(
                   children: [
                    Expanded(
                     child: CupertinoButton(
                      borderRadius: const BorderRadius.all(Radius.circular(60)),
                      color: const Color(0xffff5954),
                      onPressed: (() {
                    FirebaseAuth.instance.sendPasswordResetEmail(email:_emailController.text).
                    then((value) => Navigator.of(context).pop());
                      }),
                   child: const Text('réientaliser mot de passe', 
                   style: TextStyle(color: Colors.white)))),
                    ],
                 ),
               ),
                const SizedBox(height: 2,),
                   Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                  const Text("Vous n'avez pas un compte ?",style:
                          TextStyle(color: Colors.grey,)),
                          TextButton(onPressed: (){
                             Navigator.pushReplacement(
                               context,
                                 CupertinoPageRoute(
                                    builder: (context) => SignupScreen()));}, 
                           child: const Text("S'inscrire", style:
                                     TextStyle(color:Color(0xff2657ce))))],
            ),
           ], 
         ),
      ),
     ), 
    );
  }
}