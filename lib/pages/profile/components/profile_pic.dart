//hedhy taswira ta3 profile kahaw eli 3ayetlha f page ta3 bodyProfile


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class profilpic extends StatelessWidget {
  const profilpic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 115,width: 115,
    child: 
      Stack(
    //overflow:Overflow.visible, 3awedhthaz
    clipBehavior: Clip.none,
    fit: StackFit.expand,
      children:[ CircleAvatar(
      backgroundImage: AssetImage('assets/images/profile.png',)
      ),
      Positioned(
        top: 100,
        right: -12,
        bottom: 110,
        child: SizedBox(
          height: 46,
          width: 46,
          child: CupertinoButton(//flatbutton shape
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(50),
            color: Color(0xFFF5F6F9),
            onPressed:(){},
            child : Icon(Icons.edit,color:Color(0xffff5954)
            //kifeh icon svg
          ),
        )
      ),
    ),
       ]) );
  }
}