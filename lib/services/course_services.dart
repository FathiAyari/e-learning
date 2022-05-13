import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CourseServices {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<QuerySnapshot> fetchCourse() async {//hedhy l fonct esmha fetchcourse
    print('to str: ${_firebaseFirestore.collection('course').get().toString()}');
    return _firebaseFirestore.collection('course').get();
  }
}
//.get()=bch njib les document lkol li f west l coolection course
//.doc()=ken hatyt .dac ray  jebtli document wehd
//document wehd bch njibou mn firebase = list snapshot
//bch njib barcha document nhot = list Query 
// ahna 3malna document 3 leh mafhemthch