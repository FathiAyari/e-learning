import 'package:flutter/material.dart';

import 'add_course.dart';
import 'list_course.dart';

//ne9es flech yraja3ni lel lpage li 9balha
class HomeCourse extends StatefulWidget {
  HomeCourse({Key? key}) : super(key: key);

  @override
  _HomeCourseState createState() => _HomeCourseState();
}

class _HomeCourseState extends State<HomeCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffff5954),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('listes des cours'),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCourse(),
                  ),
                )
              },
              child: Text('Ajouter cours', style: TextStyle(fontSize: 20.0)),
              style: ElevatedButton.styleFrom(primary: Color(0xff2657ce)),
            )
          ],
        ),
      ),
      body: ListCourse(),
    );
  }
}
