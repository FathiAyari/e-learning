import 'package:firebase_auth/firebase_auth.dart';

import '../Models/user.dart';
import 'DbServices.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
// creation d'instance de firebase auth
  //Authentification => instance firebaseAuth
  // base de donnée => instance firestore
  // stockage => instance  firestorage
  Future<bool> signIn(String emailController, String passwordController) async {
    try {
      // try => jarreb el code hedha
      // await => yestana lin tekml el tache => order pour attendre la fin de tache
      // await ma t5dem kan m3a el async
      await auth.signInWithEmailAndPassword(
          email: emailController, password: passwordController);
      print("done");
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signUp(String emailController, String passwordController,
      String name, String urlController, String GsmController) async {
    try {
      //etape 1 : creation de compte
      await auth.createUserWithEmailAndPassword(
          email: emailController, password: passwordController);

      await DbServices().saveUser(Cusers(
        uid: user!.uid,
        name: name,
        Email: emailController,
        Role: "client",
        Url: urlController,
        Gsm: GsmController,
      )); // à travers le formulaire
      print("done");
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(String emailController) async {
    try {
      await auth.sendPasswordResetEmail(email: emailController);
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  User? get user => auth.currentUser; //pour recuperer l'utilisateur courant
}
