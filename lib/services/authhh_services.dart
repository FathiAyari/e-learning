import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/enddd_users.dart';


class AuthService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final GoogleSignIn _googleAuth = GoogleSignIn();

  //Init Firebase user
  EndUser _userFirebaseUser(User? firebaseUser) {
    return EndUser(
      uid: firebaseUser!.uid,
    );
  }

  //Signin Email/Pass
  Future loginUser(String login, String password) async {
    try {
      UserCredential endUserCredentials = await _firebaseAuth
          .signInWithEmailAndPassword(email: login, password: password);
      User firebaseUser = endUserCredentials.user!;
      return _userFirebaseUser(firebaseUser);
    } catch (e) {
      print('Account login failed, reason: ' + e.toString());
      return null;
    }
  }

  //Signup Email/Pass
  Future registerUser(String email, String password , String nomPrenom )   async {
    try {
      UserCredential endUserCredentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = endUserCredentials.user!;
      return _userFirebaseUser(firebaseUser);
    } catch (e) {
      print('Account creation failed, reason: ' + e.toString());
      return null;
    }
  }

  Future createUserDocument(String docId, EndUser mUser) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(docId)
          .set(mUser.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future updateUserDocument(String docID) async {
    EndUser updatedUser = EndUser(phone: '5523564', username: 'ahlem', uid: '');//hedhy instance 
    //hedha objet EndUser esmou updatedUser
    try {
      await _firebaseFirestore//ml firestore
          .collection('users')//l collection mnin esm l collection
          .doc(docID)//tekhou l id mta3 document hedhom
          .update(updatedUser.toJsonUpdate());//esm l user li bch nbadlou howa updatedUser .toJsonUpdate heya liste 
    } catch (e) {
      print(e);
    }
  }

  Future deleteUser() async {
    try {
      _firebaseFirestore.collection('users').doc('senda').delete(); // bch tgfasa5li id john
    } catch (e) {
      print(e);
    }
  }

  //Sign out
  Future<void> logout() async {
    try {
      print('logging out...');
      //await _googleAuth.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<EndUser>? get user {
    return _firebaseAuth.authStateChanges().map(_userFirebaseUser);
  }
}
/* //boutton li bch tfasakhli user
              TextButton(
                  onPressed: () {
                    _authService.deleteUser();
                  },
                  child: Text('delete john')),//bch tfasakhli user id jhon*/
 /* //boutton update 
   TextButton(
                child: Text('update phone'),
                onPressed: () {
                  _authService.updateUserDocument(
                      FirebaseAuth.instance.currentUser!.uid);*/
//lcrud ta3 read lel course
       /* FutureBuilder<QuerySnapshot>(//hedhy li bch tjibli les cours eli houma lista ta3 document mte3i ml firebase
          // ken mana3rech type liste nahi<QuerySnapshot>
              future: _courseServices.fetchCourse(),
              //_courseServices = heka l varibla li bch yjini fih resulat .fetchCourse()= eli heya l fontion kifeh bch yjibli document mte3i
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //listView= GridView = nhot li 3andi kifeh bch yafichihomli
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,//hedhy khater na3rech 9adeh 3andi men doc f coolec course² 
                     //snapshot= résulat, traja3 barcha hajetb (etat ta3 haja)
                     //.length = bch na3ref 9adeh men document 3andi
                     // Data = heya les donnees mte3i lkol ynajmou ykounou ferghhin ynajmou ykounou le 
                     //! = ya3ni 9ad ykoun data fergha
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data!.docs[index]['programmation']),//esm document 3andy
                          //na3mel f parcour mte3i ,f document
                          //snapshot = howa li fyh kol chy ta3 firestore
                        );
                      });
                } else {
                  return Center(
                    child: SizedBox(
                      height: 43,
                      width: 43,
                      child: CircularProgressIndicator(),//hedh aka loading
                    ),
                  );
                }
              })   */             